
# 🎮 Doodle Jump in 8086 Assembly

## 📘 Overview

This project is a unique implementation of **Doodle Jump** written in **8086 assembly language**. The player controls a ball that jumps across dynamic pads, avoiding obstacles and hazards while aiming to reach new heights. The game includes different types of pads, dynamic physics, and sound effects for an engaging retro gaming experience.

## ✨ Features

- 🕹️ **Player Control**: The player controls a ball that jumps across the screen.
- 🔄 **Dynamic Pads**: Pads appear and disappear, requiring the player to react quickly.
- ⚠️ **Broken Pads**: Some pads break on impact, adding difficulty to the game.
- 🚀 **Jump Pads**: Special pads propel the ball higher, giving a boost.
- 🐜 **Insects**: Insects appear as enemies, and colliding with them will result in a game over.
- 🎢 **Gravity and Physics**: The ball accelerates when falling and decelerates when jumping upwards.
- 🔊 **Sound Effects**: The game features sound effects to enhance the player's experience.

## 🚀 How to Play

1. **Launch the game** on an 8086 emulator or compatible environment.
2. Use the **arrow keys** to control the ball’s movement.
3. **Jump** from pad to pad to avoid falling off the screen.
4. Watch out for **broken pads** that shatter upon landing.
5. Use **jump pads** to get a speed boost and avoid falling.
6. Avoid **insects** that will end the game if touched.
7. The goal is to survive as long as possible while going higher!

![](https://github.com/ParsaJahantab/assembly-doodle-jump/blob/main/doodle.gif)

## 📋 Controls

- **A/D keys**: Move the ball left or right.
- **Automatic Jump**: The ball continuously jumps, and you guide it from pad to pad.

## 🛠️ Installation and Setup

1. **Install DOSBox** on your system. You can download it from [https://www.dosbox.com/](https://www.dosbox.com/).
2. **Compile the ASM file** using **MASM**:
   ```bash
   masm project.asm
   ```
3. **Link the file**:
   ```bash
   link project
   ```
4. **Run the `.exe` file** using DOSBox:
   - Open DOSBox.
   - Navigate to the folder containing your `.exe` file.
   - Run the game by typing:
     ```bash
     project
     ```
