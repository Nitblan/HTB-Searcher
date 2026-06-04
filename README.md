# HTB-Searcher

A lightweight and fast **Hack The Box machine search utility written in Bash**.

HTB-Searcher allows you to quickly search and filter Hack The Box machines using simple command-line flags, making it easy to find targets based on difficulty, operating system, skills, and other criteria.

---

## What can you do?

* Fast machine lookup from the terminal.
* Search by difficulty.
* Search by operating system.
* Filter machines by technologies and skills.
* Simple and lightweight Bash implementation.
* Inspired by the usability of tools like Nmap.

---

## How to use it

Clone the repository:

```bash
git clone https://github.com/Nitblan/HTB-Searcher.git
cd HTB-Searcher
```

Grant execution permissions:

```bash
chmod +x SearcherHTBMachines.sh
```

Run the tool:

```bash
./SearcherHTBMachines.sh
```

---

## Usage

Display available options:

```bash
./SearcherHTBMachines.sh -h
```

Search machines by difficulty:

```bash
./SearcherHTBMachines.sh -d Easy
```

Search by operating system:

```bash
./SearcherHTBMachines.sh -o Linux
```

Combine filters as needed to narrow down results.

---

## Important Note!

This project relies on a generated JavaScript bundle used for data processing.

**Do not remove the generated `.js` bundle file**, as the tool depends on it to function correctly.

---

## Credits

Special thanks to **S4vitar** for the inspiration and educational content that motivated the development of this project.

---

## Disclaimer

This project is intended for educational purposes and to facilitate navigation through publicly available Hack The Box machine information.

HTB-Searcher is an independent community project and is not affiliated with Hack The Box.
