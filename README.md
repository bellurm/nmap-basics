# nmap-basics

An interactive Bash-based Nmap learning and reconnaissance utility.

`nmap-basics` provides a menu-driven interface for building Nmap commands while explaining what common scanning, discovery, enumeration, timing, and NSE options do.

The project was created as a practical way to learn Nmap by using it rather than simply memorizing command-line arguments.

---

## Overview

Nmap is an extremely powerful network discovery and security auditing tool, but its large number of options can be difficult to remember when first learning it.

This project provides an interactive terminal menu that allows users to select Nmap options step by step.

Selected options are combined into a final Nmap command and executed against an authorized target.

```text
Select scan options
        │
        ▼
Build Nmap arguments
        │
        ▼
Enter target
        │
        ▼
Execute scan
        │
        ▼
Review Nmap results
```

---

## Features

The current menu includes 37 selectable Nmap options covering several categories.

### Port Scanning

Supports:

- Specific port selection (`-p`)
- TCP SYN scanning (`-sS`)
- UDP scanning (`-sU`)
- FIN scanning (`-sF`)
- All TCP ports (`-p-`)
- Fast scan of common ports (`-F`)
- Custom top-port count (`--top-ports`)

---

## Host Discovery

Includes several Nmap host-discovery techniques:

- Skip host discovery (`-Pn`)
- Ping scan / host discovery (`-sn`)
- TCP SYN ping (`-PS`)
- TCP ACK ping (`-PA`)
- UDP ping (`-PU`)
- ARP discovery (`-PR`)

The utility can also read targets from a file using:

```text
-iL <file>
```

---

## Service & Version Detection

Supported options include:

```text
-sV
```

for service/version detection.

The menu also provides:

```text
-sV --version-intensity <0-9>
```

for controlling version-detection intensity, and:

```text
-sV --version-all
```

for trying all available version-detection probes.

---

## Operating System Detection

The project exposes several Nmap OS-detection options:

```text
-O
```

Basic OS detection.

```text
-O --osscan-limit
```

Limits OS detection to hosts that meet Nmap's required conditions.

```text
-O --max-os-tries <value>
```

Controls the maximum number of OS detection attempts.

```text
-O --osscan-guess
```

Allows Nmap to make more aggressive OS guesses.

---

## Aggressive Enumeration

The utility supports:

```text
-A
```

Nmap's aggressive detection mode.

Depending on the target and environment, this may enable functionality such as:

- OS detection
- Version detection
- Script scanning
- Traceroute

---

## Timing Templates

All major Nmap timing templates are available:

```text
-T0
-T1
-T2
-T3
-T4
-T5
```

These represent different timing strategies ranging from very slow/conservative scanning to very fast scanning.

The appropriate timing template depends on the network environment and purpose of the scan.

---

## Nmap Scripting Engine

The utility includes several NSE-related options.

### Default Scripts

```text
--script=default
```

Runs Nmap's default script category.

### Vulnerability Scripts

```text
--script vuln
```

Runs scripts categorized by Nmap as vulnerability-related.

### Authentication Scripts

```text
--script auth
```

Runs authentication-related NSE scripts.

### Exploit Category

```text
--script exploit
```

Provides access to scripts in Nmap's exploit category for controlled security laboratory and authorized testing environments.

### Protocol-Specific Scripts

The tool can list locally installed NSE scripts and allows selection of script families such as:

```text
http-*
ssh-*
dns-*
```

For example:

```text
--script http-*
```

---

## Additional Scan Options

The menu also exposes several additional Nmap capabilities.

### Packet Fragmentation

```text
-f
```

Requests IP packet fragmentation.

### Decoy Scanning

```text
-D RND:<value>
```

Adds randomly generated decoy addresses to supported scan types.

### MAC Address Spoofing

```text
--spoof-mac 0
```

Requests a random MAC address where supported.

### Verbose Output

```text
-v
```

Enables more detailed Nmap output.

---

## Requirements

- Linux
- Bash
- Nmap
- Root privileges for scan types that require raw packet access

On Debian/Ubuntu systems:

```bash
sudo apt update
sudo apt install nmap
```

---

## Installation

Clone the repository:

```bash
git clone https://github.com/bellurm/nmap-basics.git
cd nmap-basics
```

Make the script executable:

```bash
chmod +x nmap_tut.sh
```

---

## Usage

Run the script with root privileges:

```bash
sudo ./nmap_tut.sh
```

The interactive menu will display the available scanning options.

You can select multiple options before starting a scan.

Example workflow:

```text
Select option 2
→ TCP SYN Scan (-sS)

Select option 15
→ Version Detection (-sV)

Select option 24
→ Timing Template (-T4)

Type:
exit

Enter target:
192.168.1.10
```

The resulting command will be similar to:

```bash
nmap -sS -sV -T4 192.168.1.10
```

---

## Target Formats

When starting a scan, the script accepts common Nmap target formats such as:

### Single IP address

```text
192.168.1.10
```

### CIDR network

```text
192.168.1.0/24
```

### Domain name

```text
example.com
```

Nmap-supported target formats may also be used depending on the selected scan options.

---

## Menu Workflow

Options selected from the menu are stored and combined before execution.

```text
┌─────────────────────────┐
│    Interactive Menu     │
└────────────┬────────────┘
             │
             ▼
      Select Nmap option
             │
             ▼
      Add to scan command
             │
             ├──── Select another option
             │
             ▼
          Type "exit"
             │
             ▼
         Enter target
             │
             ▼
         Execute Nmap
```

Typing:

```text
exit
```

starts the configured scan.

Typing:

```text
done
```

terminates the program.

---

## What This Project Demonstrates

This project provides hands-on practice with:

- Bash scripting
- Interactive CLI design
- Linux command-line tooling
- Nmap
- TCP and UDP scanning
- Network reconnaissance
- Host discovery
- Service enumeration
- OS fingerprinting
- Nmap Scripting Engine
- Network timing concepts
- Bash arrays and command construction

---

## Educational Purpose

The primary goal of this repository is to make learning Nmap more interactive.

Instead of memorizing commands such as:

```bash
nmap -sS -sV -O -T4 <target>
```

the user can select individual behaviors from the menu and observe how those selections translate into actual Nmap arguments.

This makes the project useful as both:

- A small reconnaissance utility
- A hands-on Nmap learning exercise

---

## Limitations

This project is a learning utility rather than a replacement for the Nmap command-line interface.

Some option combinations may not be valid together, and Nmap itself remains responsible for validating the final command.

Certain scan types also depend on:

- Operating system support
- Network configuration
- User privileges
- Nmap version
- Target behavior

Users should understand the Nmap options they select rather than treating the menu as an automatic scan recommendation system.

---

## Security & Responsible Use

This project is intended for:

- Cybersecurity education
- Personal laboratories
- CTF environments
- Network administration
- Authorized penetration testing
- Security research

Only scan systems and networks that you own or have explicit permission to test.

The presence of an option in this utility does not imply authorization to use it against third-party infrastructure.

---

## Author

**Cyber Worm**

GitHub: [@bellurm](https://github.com/bellurm)
