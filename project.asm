
.MODEL LARGE
STACK SEGMENT PARA STACK
	DB 64 DUP (' ')
STACK ENDS

DATA SEGMENT PARA 'DATA'

	; Define initial position of the ball on the screen
	BALL_X DW 70       ; X-coordinate position of the ball
	BALL_Y DW 30D      ; Y-coordinate position of the ball
	
	PREV_BALL_X DW 0
	PREV_BALL_Y DW 0
	
	CURRENT_BALL_X DW 70
	CURRENT_BALL_Y DW 70
	
	ERASE_BALL DW 0
	
	BALL_COLOR DB 0
	
	; Define the size and radius of the ball
	BALL_RADUIS DW 4H    ; Radius of the ball
	
	BALL_LOCAL_X DW 00H
    BALL_LOCAL_Y DW 00H
	decision DW 00H
    BALANCE DW 00H
	
	; Define the initial velocity of the ball in the x and y direction
	BALL_VELOCITY_X DW 04H ; Velocity of the ball in the x-direction
	BALL_VELOCITY_Y DW 03H ; Velocity of the ball in the y-direction
	
	; Define the acceleration of the ball and how long it should wait before accelerating in a given direction
	BALL_ACCELERATION DW 01H                   ; Acceleration rate of the ball
	BALL_ACCELERATION_COUNTDOWN DW 10D         ; Countdown before the acceleration
	ACCELERATION_DIRECTION DW 00H              ; Direction of the acceleration (0 is positive, 1 is negative)
	
	
	; Define the variables that determine the position, size and gameplay elements of the platform.
	LEFT_PLATFORM_X DW 70         ; X-coordinate position of the platform
	LEFT_PLATFORM_Y DW 175        ; Y-coordinate position of the platform
	
	PREV_LEFT_PLATFORM_X DW 00H
	PREV_LEFT_PLATFORM_Y DW 00H
	
	
	; Define the right platform's x and y coordinates using a 2-byte data variable.
	RIGHT_PLATFORM_X DW 210
	RIGHT_PLATFORM_y DW 20
	
	PREV_RIGHT_PLATFORM_X DW 00H
	PREV_RIGHT_PLATFORM_Y DW 00H

	; Define the active platform's x and y coordinates using a 2-byte data variable.
	ACTIVE_PLATFORM_X DW 70
	ACTIVE_PLATFORM_Y DW 175

	; Define the draw platform's x and y coordinates using a 2-byte data variable.
	DRAW_PLATFORM_X DW 70        
	DRAW_PLATFORM_Y DW 175        

	; Define the active platform using a 1-byte data variable, set to 0.
	ACTIVE_PLATFORM DW 00H

	; Define the "to draw" variable using a 1-byte data variable, set to 0.
	TO_DRAW DB 00H

	; Define the x and y coordinates of an inactive platform using a 2-byte data variable, set to 0.
	INACTIVE_PLATFORM_X DW 00H
	INACTIVE_PLATFORM_Y DW 00H	
	INACTIVE_PLATFORM_DESTROYED DW 00H ; Define a 1-byte data variable to determine whether the inactive platform is destroyed or not, set to 0.	
	INACTIVE_PLATFORM_MOVING DW 00H ; Define a 1-byte data variable to determine whether the inactive platform is moving or not, set to 0.


	
	PLATFORM_WIDTH DW 30D    ; Width of the platform
	PLATFORM_HEIGHT DW 03H   ; Height of the platform
	
	TOP_BORDER_Y DW 0        ; Position of the top border of the game screen
	BOTTOM_BORDER_Y DW 200D  ; Position of the bottom border of the game screen
	LEFT_BORDER_X DW 0
	RIGHT_BORDER_X DW 320D
	
	LOCALVARS DW 0H,0H       ; Temporary storage for local variables
	
	BUFFER DB 10,?,10 DUP(' ')   ; A buffer to temporarily store text data 
	
	SCORE DW 0              ; Keeps track of the player's score
	
	Time_AUX DB 0            ; A timer variable used for timing events in the game
	
	IS_GAME_ACTIVE DB 0      ; A flag to keep track of whether the game is currently active
	
	MAIN_MENU_TEXT DB 'MAIN MENU $'                     ; Text displayed on the main menu screen
	START_GAME_TEXT DB ' TO START GAME PRESS ENTER $'    ; Text displayed when the game is ready to be started
	
	GAME_OVER_TEXT DB 'GAME OVER$'                       ; Text displayed when the game is over
	SCORE_TEXT DB 'SCORE:$'                              ; Text label for displaying the player's score
	RESTART_GAME_TEXT DB 'PRESS ENTER TO RESTART THE GAME$'    ; Text displayed when the game is over and giving the player the option to restart
	END_GAME_TEXT DB 'PRESS ESC TO EXIT THE GAME $'      ; Text displayed when the game is over and prompting the player to exit.
	
	
	; This section declares variables for a broken platform game object

	BROKEN_PLATFORM_ACTIVE DB 0          ; Declaration of variable for status of game object - active (1) or inactive (0)
	BROKEN_PLATFORM_X      DW 00H        ; Declaration of variable for x-coordinate of game object
	BROKEN_PLATFORM_Y      DW 00H        ; Declaration of variable for y-coordinate of game object
	BROKEN_PLATFORM_IS_DESTROYED DB 00H ; Declaration of variable for status of game object - destroyed (1) or not destroyed (0)
	CHECKING_FOR_BROKEN_PLATFORM_COLLISION DB 00H ; Declaration of variable for checking collision of game object with other objects
	
	PREV_BROKEN_PLATFORM_X DW 00H
	PREV_BROKEN_PLATFORM_Y DW 00H

	
	; The following code is written in assembly programming language
	; This section declares variables for an insect game object

	CHANGE_ACCELERATION DB 00H   ; Declaration of variable for change in acceleration of game object
	INSECT_X DW 0               ; Declaration of variable for x-coordinate of game object
	INSECT_Y DW 0               ; Declaration of variable for y-coordinate of game object
	INSECT_VELOCITY DW 3D       ; Declaration of variable for velocity of game object
	INSECT_ACTIVE DW 1          ; Declaration of variable for status of game object - active (1) or inactive (0)
	INSECT_SIZE DW 5H           ; Declaration of variable for size of game object
	INSECT_DESTROYED DW 0H      ; Declaration of variable for status of game object - destroyed (1) or not destroyed (0)
	
	PREV_INSECT_X DW 00H
	PREV_INSECT_Y DW 00H
	INSECT_ERASE DB 00H
	INSECT_COLOR DB 00H
	
	CURRENT_INSECT_X DW 00H
	CURRENT_INSECT_Y DW 00H

	TO_ERASE_X DW 00H
	TO_ERASE_Y DW 00H
	


		; The following code is written in assembly programming language
		; This section declares variables for a coil platform game object and the coil object.

	COIL_PLATFORM_ACTIVE DB 0                       ; Declaration of variable for status of coil platform - active (1) or inactive (0)
	COIL_PLATFORM_CHANCE DB 00H                     ; Declaration of variable for the probability of generating coil platform
	COIL_PLATFORM_X      DW 00H                     ; Declaration of variable for x-coordinate of coil platform
	COIL_PLATFORM_Y      DW 00H                     ; Declaration of variable for y-coordinate of coil platform
	COIL_PLATFORM_IS_DESTROYED DB 00H               ; Declaration of variable for status of coil platform - destroyed (1) or not destroyed (0)
	CHECKING_FOR_COIL_PLATFORM_COLLISION DB 00H     ; Declaration of variable for collision detection on coil platform
	
	PREV_COIL_PLATFORM_X DW 00H
	PREV_COIL_PLATFORM_Y DW 00H

	COIL_ACTIVE DB 0                                ; Declaration of variable for status of coil - active (1) or inactive (0)

	COIL_VELOCITY DW 15                             ; Declaration of variable for the speed  that coil adds

	
	INACTIVE_MOVED DB 0
	
	ADD_TO_BALL_VELOCITY DW 2
	
	
	
	DATA ENDS                ; Indicates the end of the data segment
	
	
	


CODE SEGMENT PARA 'CODE'

	MAIN PROC FAR
	; The following lines tell the program which segments of memory to use for code, data, and stack
		ASSUME CS:CODE,DS:DATA,SS:STACK 
		PUSH DS ; This pushes the data segment onto the stack
	
	; The next few lines set up the data segment correctly
		SUB AX,AX ; Sets AX register to zero
		PUSH AX ; Pushes register AX onto the stack
		MOV AX,DATA ; Loads the address of the data segment into AX
		MOV DS,AX ; Copies the contents of AX into DS
		POP AX ; Pops the value of AX from the stack
	
	; The following lines sets up the display mode
		MOV AH,00H ; Sets up function number 00H (set video mode), in AH register
		MOV AL,13H ; Set the display mode to 13H, (320x200 pixels, 256 colors)
		INT 10H ; Invokes the BIOS video service routine.
	
	
		; This code describes a loop in assembly language that displays a main menu screen and waits for user input
		
		MAIN_MENU:
			
			CALL MAIN_MENU_SCREEN ; Calls the MAIN_MENU_SCREEN subroutine, which displays the main menu
			
			MOV AH,00H ; Sets up function number 00H (keyboard input), in the AH register
			INT 16H ; Waits for keyboard input and stores it in the AL register
		
			CMP AL,13 ; Compares the value in the AL register to 13 (Enter key)
			JE ACTIVE_GAME ; If the user pressed Enter, jumps to the ACTIVE_GAME section of the program 
		
			CMP AL,27 ; Compares the value in the AL register to 27 (Escape key)
			JE END_GAME ; If the user pressed Escape, jumps to the END_GAME section of the program
		
			JMP MAIN_MENU ; If neither Enter nor Escape was pressed, jumps back to the beginning of the MAIN_MENU loop to display the menu again
		
			
			
		; This code describes the ACTIVE_GAME section of a program in assembly language that initializes game values when the user enters a game mode
		
		ACTIVE_GAME:
			
			MOV CHANGE_ACCELERATION,0
			MOV INACTIVE_MOVED,0
			
			MOV PREV_LEFT_PLATFORM_X,00H
			MOV PREV_LEFT_PLATFORM_Y,00H
			
			
			MOV PREV_RIGHT_PLATFORM_X,00H
			MOV PREV_RIGHT_PLATFORM_Y,00H
			
			MOV PREV_BROKEN_PLATFORM_X,00H
			MOV PREV_BROKEN_PLATFORM_Y,00H
			
			MOV PREV_COIL_PLATFORM_X,00H
			MOV PREV_COIL_PLATFORM_Y,00H
			
			MOV PREV_BALL_X,0
			MOV PREV_BALL_Y,0
			
			MOV CURRENT_BALL_X,70
			MOV CURRENT_BALL_Y,70
			
			MOV ERASE_BALL,0
			
			MOV BALL_COLOR,0
			
			MOV INSECT_ERASE,00H
			MOV INSECT_COLOR,00H
	
			MOV CURRENT_INSECT_X,00H
			MOV CURRENT_INSECT_Y,00H
			
			MOV AX,70 ; Set the X coordinate of the ball to 70
			MOV BALL_X,AX ; Store the value of AX (70) in the variable BALL_X
			MOV AX,30 ; Set the Y coordinate of the ball to 30
			MOV BALL_Y,AX ; Store the value of AX (30) in the variable BALL_Y
			MOV ACCELERATION_DIRECTION,0
			MOV BALL_VELOCITY_Y,3
			
			MOV AX,70 ; Set the X coordinate of the platform to 70
			MOV LEFT_PLATFORM_X,AX ; Store the value of AX (70) in the variable LEFT_PLATFORM_X
			MOV AX,175 ; Set the Y coordinate for the position of the platform to 175
			MOV LEFT_PLATFORM_Y,AX ; Store the value of AX (175) in the variable LEFT_PLATFORM_Y
			
			MOV AX,70 ; Set the X coordinate of the platform to 70
			MOV ACTIVE_PLATFORM_X,AX ; Store the value of AX (70) in the variable ACTIVE_PLATFROM_X
			MOV AX,175 ; Set the Y coordinate for the position of the platform to 175
			MOV ACTIVE_PLATFORM_Y,AX ; Store the value of AX (175) in the variable ACTIVE_PLATFORM_Y
			
			MOV AX,70 ; Set the X coordinate of the platform to 70
			MOV DRAW_PLATFORM_X,AX ; Store the value of AX (70) in the variable DRAW_PLATFORM_X
			MOV AX,175 ; Set the Y coordinate for the position of the platform to 175
			MOV DRAW_PLATFORM_Y,AX ; Store the value of AX (175) in the variable DRAW_PLATFORM_Y
			
			MOV AX,210 ; Set the X coordinate of the platform to 210
			MOV RIGHT_PLATFORM_X,AX ; Store the value of AX (210) in the variable RIGHT_PLATFROM_X
			MOV AX,-20 ; Set the Y coordinate for the position of the platform to -20
			MOV RIGHT_PLATFORM_Y,AX ; Store the value of AX (-20) in the variable RIGHT_PLATFORM_Y
			
			
			MOV INACTIVE_PLATFORM_DESTROYED,0 ; Set the INACTIVE_PLATFORM_DESTROYED flag variable to 0, indicating that the inactive platform is not destroyed.
			MOV INACTIVE_PLATFORM_MOVING,0 ; Set the INACTIVE_PLATFORM_MOVING flag variable to 0, indicating that the inactive platform is not moving.
			MOV ACTIVE_PLATFORM,0 ; Set the ACTIVE_PLATFORM variable to 0, indicating that there is no active platform currently in use.
			MOV TO_DRAW,0 ; Set the TO_DRAW variable to 0, indicating that there is nothing currently in the screen buffer to draw.

			MOV AX,150 ; Set the X coordinate of the platform to 150
			MOV BROKEN_PLATFORM_X,AX ; Store the value of AX (150) in the variable BROKEN_PLATFROM_X
			MOV AX,-60 ; Set the Y coordinate for the position of the platform to -20
			MOV BROKEN_PLATFORM_Y,AX ; Store the value of AX (-20) in the variable BROKEN_PLATFORM_Y
			
			MOV BROKEN_PLATFORM_ACTIVE,0
			MOV BROKEN_PLATFORM_IS_DESTROYED,0
			MOV CHECKING_FOR_BROKEN_PLATFORM_COLLISION,0
			
			
			MOV AX,50 ; Set the X coordinate of the platform to 280
			MOV COIL_PLATFORM_X,AX ; Store the value of AX (280) in the variable COIL_PLATFROM_X
			MOV AX,-30 ; Set the Y coordinate for the position of the platform to -60
			MOV COIL_PLATFORM_Y,AX ; Store the value of AX (-60) in the variable COIL_PLATFORM_Y
			
			MOV COIL_PLATFORM_ACTIVE,1
			MOV COIL_PLATFORM_IS_DESTROYED,0
			MOV CHECKING_FOR_COIL_PLATFORM_COLLISION,0
			
			
			
			MOV INSECT_X, 20 ; Move the value 20 into INSECT_X
			MOV INSECT_Y, -5 ; Move the value -5 into INSECT_Y
			MOV INSECT_ACTIVE, 0 ; Move the value 0 into INSECT_ACTIVE		
			MOV INSECT_SIZE, 5 ; Move the value 5 into INSECT_SIZE	
			MOV INSECT_DESTROYED, 0 ; Move the value 0 into INSECT_DESTROYED

			

			
			MOV COIL_ACTIVE,0
			
		
			MOV AX,0 ; Initiate score to zero
			MOV SCORE,AX ; Store the value of AX (0) in the variable SCORE
		
			MOV AL,1 ; Sets IS_GAME_ACTIVE flag to 1 indicating that the game is active
			MOV IS_GAME_ACTIVE,AL ; Store the value of AL (1) in the variable IS_GAME_ACTIVE
		
			MOV AL,13H ; Set the display mode to 13H, (320x200 pixels, 256 colors)
			MOV AH,0 ; Sets up function number 00H (set video mode), in the AH register
			INT 10H ; Invokes the BIOS video service routine.
			
			CALL CLEAR_SCREEN ; Clears the screen
			
			
; This code describes a main loop in assembly language that updates the state of the game and loops until the game is over

			MAIN_LOOP:

				MOV AH,2CH ; Obtains the number of clock ticks since midnight and stores it in DX:AX
				INT 21H ; Invokes DOS service routine for getting system time

				CMP DL,Time_AUX ; Compares current time with previous stored time (in Time_AUX) 
				JE MAIN_LOOP ; If the time hasn’t changed yet, jumps back to the beginning of the loop

				MOV Time_AUX,DL ; Store the current time in Time_AUX

				CALL COIL_PLATFORM_HANDLER
				CALL BROKEN_PLATFORM_HANDLER
				;CALL COIL_PLATFORM_HANDLER
				CALL INSECT_HANDLER
				INC ERASE_BALL
				CALL DRAW_BALL ; Draws the ball
				CALL MOVE_BALL_HORIZANTAL ; Updates the ball's horizontal movement
				CALL MOVE_BALL_VERTICAL ; Updates the ball's vertical movement
				DEC ERASE_BALL
				CALL DRAW_BALL ; Draws the ball
				CALL MOVE_PLATFORM
				CALL ERASE_PLATFORMS
				CALL INACTIVE_PLATFORM_HANDLER
				CALL DRAW_PLATFORM ; Draws the platform
				INC TO_DRAW
				CALL DRAW_PLATFORM
				INC TO_DRAW
				CALL DRAW_PLATFORM
				INC TO_DRAW
				CALL DRAW_PLATFORM
				DEC TO_DRAW
				DEC TO_DRAW
				DEC TO_DRAW
				CALL SET_PREV

				CALL CHECK_COLLISION ; Checks if the ball collides with an object
				CALL CHECK_BORDERS ; Check if the ball reaches the borders of the game screen
				CALL intToString ; Converts the score to a string
				CALL printString ; Prints the score on the screen
				MOV AL,IS_GAME_ACTIVE ; Load the value of the IS_GAME_ACTIVE flag into the AL register
				CMP AL,0 ; Compare the value in the AL register to zero
				JE GAME_OVER ; If the value in AL is zero (game over), jump to the GAME_OVER subroutine
				JMP MAIN_LOOP ; If the game is not over, jump back to the beginning of the MAIN_LOOP to continue the game
							
				RET
			; This code describes the GAME_OVER subroutine in assembly language that shows a game over screen and waits for user input

			GAME_OVER:
				
				CALL GAME_OVER_SCREEN ; Calls the GAME_OVER_SCREEN subroutine, which displays the game over screen

			WAIT_FOR_INPUT:
				
				MOV AH,00H ; Sets up function number 00H (keyboard input), in the AH register
				INT 16H ; Waits for keyboard input and stores it in the AL register

				CMP AL,13 ; Compares the value in the AL register to 13 (Enter key)
				JE ACTIVE_GAME ; If the user pressed Enter, jumps to the ACTIVE_GAME section of the program 

				CMP AL,27 ; Compares the value in the AL register to 27 (Escape key)
				JE END_GAME ; If the user pressed Escape, jumps to the END_GAME section of the program

				JMP WAIT_FOR_INPUT ; If neither Enter nor Escape was pressed, jumps back to the beginning of the WAIT_FOR_INPUT loop
				
			END_GAME:

				MOV AH,00H ; Sets up function number 00H (set video mode), in the AH register
				MOV AL,03H ; Set the display mode to 3H (text mode, 80x25 characters)
				INT 10H ; Invokes the BIOS service routine.
				
				MOV AH,4CH ; Exit program
				INT 21H ; Invokes DOS service routine.

MAIN ENDP ; End of program. 

	;-------------------------------------------------------------------- A FUNCTION TO CLEAR THE SCREEN ---------------------------------------------------------
	CLEAR_SCREEN PROC
		
		MOV AH,00H
		MOV AL,13H  ;  Moves the hexadecimal value 13 into register AL. This value is the function code corresponding to the video mode 320x200 with 256 colors.
		INT 10H     ; sets the graphical mode. 40x25. 256 colors. 320x200 pixels
			
		MOV AH,08H
		MOV BH,00H
		MOV BL,00H ; Clears both the background and foreground colors by moving 0 into the BH and BL registers.
		INT 10H    ; Invokes the BIOS video services again to clear the screen.
		RET        ; Finally, the procedure returns using RET.
	
	CLEAR_SCREEN ENDP
	
	
	;-------------------------------------------------------------------- A FUNCTION TO DRAW THE BALL ---------------------------------------------------------
	DRAW_BALL PROC 
	
		CMP ERASE_BALL,1
		JE EARSE
		MOV AX,BALL_X
		MOV CURRENT_BALL_X,AX
		MOV PREV_BALL_X,AX
		MOV AX,BALL_Y
		MOV CURRENT_BALL_Y,AX
		MOV PREV_BALL_Y,AX
		MOV BALL_COLOR,10D
		JMP INIT_DARW
		EARSE: 
			MOV AX,PREV_BALL_X
			MOV CURRENT_BALL_X,AX
			MOV AX,PREV_BALL_Y
			MOV CURRENT_BALL_Y,AX
			MOV BALL_COLOR,00H
			
		
		
		INIT_DARW:
		MOV AX,BALL_RADUIS
        NEG AX
        MOV BALANCE,AX
        
        MOV CX,CURRENT_BALL_X
        MOV DX,CURRENT_BALL_Y
        MOV AX,BALL_RADUIS
        MOV BALL_LOCAL_X,AX
		MOV BALL_LOCAL_Y,0

        DRAW_CIRCLE_LOOP:

			MOV CX,CURRENT_BALL_X
			MOV DX,CURRENT_BALL_Y
			
			; DRAW A PIXEL AT (CENTER_X + BALL_LOCAL_X,CENTER_Y - BALL_LOCAL_Y)
			; part 1 from angle 0 to 45 counterclockwise
			ADD CX,BALL_LOCAL_X
			SUB DX,BALL_LOCAL_Y
			MOV AH,0CH
			MOV AL,BALL_COLOR
			MOV BH,00H 
			INT 10H ; Invoke the BIOS video services to display the pixel.

			MOV CX,CURRENT_BALL_X
			MOV DX,CURRENT_BALL_Y
		
			; DRAW A PIXEL AT (CENTER_X + BALL_LOCAL_Y,CENTER_Y - BALL_LOCAL_X)
			; part 2 from angle 90 to 45 clockwise
			ADD CX,BALL_LOCAL_Y
			SUB DX,BALL_LOCAL_X
			MOV AH,0CH
			MOV AL,BALL_COLOR
			MOV BH,00H 
			INT 10H ; Invoke the BIOS video services to display the pixel.
			
			MOV CX,CURRENT_BALL_X
			MOV DX,CURRENT_BALL_Y
			
			; DRAW A PIXEL AT (CENTER_X - BALL_LOCAL_Y,CENTER_Y - BALL_LOCAL_X)
			; part 3 from angle 90 to 135 counterclockwise
			SUB CX,BALL_LOCAL_Y
			SUB DX,BALL_LOCAL_X
			MOV AH,0CH
			MOV AL,BALL_COLOR
			MOV BH,00H 
			INT 10H ; Invoke the BIOS video services to display the pixel.
			
			MOV CX,CURRENT_BALL_X
			MOV DX,CURRENT_BALL_Y
			
			; DRAW A PIXEL AT (CENTER_X - BALL_LOCAL_X,CENTER_Y - BALL_LOCAL_Y)
			; part 4 from angle 180 to 135 clockwise
			SUB CX,BALL_LOCAL_X
			SUB DX,BALL_LOCAL_Y
			MOV AH,0CH
			MOV AL,BALL_COLOR
			MOV BH,00H 
			INT 10H ; Invoke the BIOS video services to display the pixel.
		
			MOV CX,CURRENT_BALL_X
			MOV DX,CURRENT_BALL_Y

			; DRAW A PIXEL AT (CENTER_X - BALL_LOCAL_X,CENTER_Y + BALL_LOCAL_Y)
			; part 5 from angle 180 to 225 counterclockwise
			SUB CX,BALL_LOCAL_X
			ADD DX,BALL_LOCAL_Y
			MOV AH,0CH
			MOV AL,BALL_COLOR
			MOV BH,00H 
			INT 10H ; Invoke the BIOS video services to display the pixel.
			
			MOV CX,CURRENT_BALL_X
			MOV DX,CURRENT_BALL_Y

			; DRAW A PIXEL AT (CENTER_X - BALL_LOCAL_Y,CENTER_Y + BALL_LOCAL_X)
			; part 6 from angle 270 to 225 clockwise
			SUB CX,BALL_LOCAL_Y
			ADD DX,BALL_LOCAL_X
			MOV AH,0CH
			MOV AL,BALL_COLOR
			MOV BH,00H 
			INT 10H ; Invoke the BIOS video services to display the pixel.
			
			MOV CX,CURRENT_BALL_X
			MOV DX,CURRENT_BALL_Y

			; DRAW A PIXEL AT (CENTER_X + BALL_LOCAL_Y,CENTER_Y + BALL_LOCAL_X)
			; part 7 from angle 270 to 315 counterclockwise
			ADD CX,BALL_LOCAL_Y
			ADD DX,BALL_LOCAL_X
			MOV AH,0CH
			MOV AL,BALL_COLOR
			MOV BH,00H 
			INT 10H ; Invoke the BIOS video services to display the pixel.
			
			MOV CX,CURRENT_BALL_X
			MOV DX,CURRENT_BALL_Y

			; DRAW A PIXEL AT (CENTER_X + BALL_LOCAL_X,CENTER_Y + BALL_LOCAL_Y)
			; part 8 from angle 360 to 315 clockwise
			ADD CX,BALL_LOCAL_X
			ADD DX,BALL_LOCAL_Y
			MOV AH,0CH
			MOV AL,BALL_COLOR
			MOV BH,00H 
			INT 10H ; Invoke the BIOS video services to display the pixel.
			

			
			MOV AX,BALANCE
			ADD AX,BALL_LOCAL_Y
			ADD AX,BALL_LOCAL_Y
			MOV BALANCE,AX

			;if (balance >= 0)
			CMP AX,0
			JL CONTINUE
			
			;BALL_LOCAL_X = BALL_LOCAL_X - 1;
			MOV AX,BALL_LOCAL_X
			DEC AX
			MOV BALL_LOCAL_X,AX

			;balance = balance - BALL_LOCAL_X - BALL_LOCAL_X
			MOV AX,BALANCE
			SUB AX,BALL_LOCAL_X
			SUB AX,BALL_LOCAL_X
			MOV BALANCE,AX

			CONTINUE:
				;BALL_LOCAL_Y = BALL_LOCAL_Y + 1
				MOV AX,BALL_LOCAL_Y
				INC AX
				MOV BALL_LOCAL_Y,AX

			LOOP_CHECK:
				MOV AX,BALL_LOCAL_Y
				MOV BX,BALL_LOCAL_X
				CMP AX,BX
				JG DRAW_BALL_FINISH
				JMP DRAW_CIRCLE_LOOP
			DRAW_BALL_FINISH:
				RET
			
	DRAW_BALL ENDP
			
		RET
		
	SET_PREV PROC
		
		MOV AX,LEFT_PLATFORM_X
		MOV PREV_LEFT_PLATFORM_X,AX
		MOV AX,LEFT_PLATFORM_Y
		MOV PREV_LEFT_PLATFORM_Y,AX
		
		MOV AX,RIGHT_PLATFORM_X
		MOV PREV_RIGHT_PLATFORM_X,AX
		MOV AX,RIGHT_PLATFORM_Y
		MOV PREV_RIGHT_PLATFORM_Y,AX
		
		MOV AX,BROKEN_PLATFORM_X
		MOV PREV_BROKEN_PLATFORM_X,AX
		MOV AX,BROKEN_PLATFORM_Y
		MOV PREV_BROKEN_PLATFORM_Y,AX
		
		MOV AX,COIL_PLATFORM_X
		MOV PREV_COIL_PLATFORM_X,AX
		MOV AX,COIL_PLATFORM_Y
		MOV PREV_COIL_PLATFORM_Y,AX
		

	
	
		RET
		
	SET_PREV ENDP
	
	ERASE_PLATFORMS PROC
	
		ERASE_LEFT_PLATFORM:
			MOV AX,LEFT_PLATFORM_Y
			CMP AX,PREV_LEFT_PLATFORM_Y
			JE ERASE_RIGHT_PLATFORM
			MOV CX,PREV_LEFT_PLATFORM_X
			MOV DX,PREV_LEFT_PLATFORM_Y

			CALL ERASE_A_PLATFORM
			
			
		ERASE_RIGHT_PLATFORM:
			MOV AX,RIGHT_PLATFORM_Y
			CMP AX,PREV_RIGHT_PLATFORM_Y
			JE ERASE_BROKEN_PLATFORM
			MOV CX,PREV_RIGHT_PLATFORM_X
			MOV DX,PREV_RIGHT_PLATFORM_Y
			CALL ERASE_A_PLATFORM
			
		
		ERASE_BROKEN_PLATFORM:
			MOV AX,BROKEN_PLATFORM_Y
			CMP AX,PREV_BROKEN_PLATFORM_Y
			JE ERASE_COIL_PLATFORM
			MOV CX,PREV_BROKEN_PLATFORM_X
			MOV DX,PREV_BROKEN_PLATFORM_Y
			CALL ERASE_A_PLATFORM
			
		ERASE_COIL_PLATFORM:
			MOV AX,COIL_PLATFORM_Y
			CMP AX,PREV_COIL_PLATFORM_Y
			JE ERASE_PLATFORM_FINISHED
			MOV CX,PREV_COIL_PLATFORM_X
			MOV DX,PREV_COIL_PLATFORM_Y
			CALL ERASE_A_PLATFORM
		
		ERASE_PLATFORM_FINISHED:
			RET
	ERASE_PLATFORMS ENDP
	
	ERASE_A_PLATFORM PROC
		
		MOV TO_ERASE_X,CX
		MOV TO_ERASE_Y,DX
		
		; Create a loop to draw  the platform horizontally
		ERASE_PLATFORM_HORIZONTAL:
			
			; Set AH to 0C (video mode), AL to 0F (light gray color), and BH to 00 for the background color
			MOV AH,0CH
			MOV AL,00H
			MOV BH,00H
			
			; Call interrupt 10h to set the video mode and colors
			INT 10H
			
			; Increment CX, then calculate the value of AX by subtracting PLATFORM_X from CX
			INC CX
			MOV AX,CX
			SUB AX,TO_ERASE_X
			
			; Compare the value of AX to PLATFORM_WIDTH. If it is less than or equal to PLATFORM_WIDTH, jump back to the DRAW_PLATFORM_HORIZONTAL label
			CMP AX,PLATFORM_WIDTH
			JNG ERASE_PLATFORM_HORIZONTAL
			
			; Reset CX to the original X value of the platform, then increment DX by 1
			MOV CX,TO_ERASE_X
			INC DX
			
			; Calculate the value of AX by subtracting PLATFORM_Y from DX, then compare it with PLATFORM_HEIGHT. If it is less than or equal to PLATFORM_HEIGHT, jump back to the DRAW_PLATFORM_HORIZONTAL label
			MOV AX,DX
			SUB AX,TO_ERASE_Y
			CMP AX,PLATFORM_HEIGHT
			JNG ERASE_PLATFORM_HORIZONTAL
			
			
		; Return control to the calling procedure
		RET
	ERASE_A_PLATFORM ENDP
	;-------------------------------------------------------------------- A FUNCTION TO MOVE THE BALL ---------------------------------------------------------
	MOVE_BALL_HORIZANTAL PROC 
	
		;CHECK FOR KEYSTROKE IN THE KEYBOARD BUFFER
		MOV AH,01H
		INT 16H
		JE MOVE_BALL_HORIZANTAL_FINISH
		; GET KEYSTROKE FROM KEYBOARD BUFFER
		MOV AH,00H
		INT 16H
		
		; CHECKS FOR 'J' OR 'j' IF EITHER OF THEM IS PRESEANT IN THE BUFFER JUMP TO THE MOVE_LEFT LABEL
		CMP AL,4AH
		JE MOVE_LEFT
		CMP AL,6AH
		JE MOVE_LEFT
		CMP AL,61H
		JE MOVE_LEFT
		CMP AL,41H
		JE MOVE_LEFT
		
		; CHECKS FOR 'K' OR 'k' IF EITHER OF THEM IS PRESEANT IN THE BUFFER JUMP TO THE MOVE_RIGHT LABEL
		CMP AL,4BH
		JE MOVE_RIGHT
		CMP AL,6BH
		JE MOVE_RIGHT
		CMP AL,44H
		JE MOVE_RIGHT
		CMP AL,64H
		JE MOVE_RIGHT
		
	
		JMP MOVE_BALL_HORIZANTAL_FINISH
		
		
		MOVE_LEFT:
			MOV AX,BALL_X
			SUB AX,BALL_VELOCITY_X
			MOV BALL_X,AX
			JMP CHECK_HORIZANTAL_BORDER_RIGHT
			
		
		MOVE_RIGHT:
			MOV AX,BALL_X
			ADD AX,BALL_VELOCITY_X
			MOV BALL_X,AX
			JMP CHECK_HORIZANTAL_BORDER_RIGHT
		
		CHECK_HORIZANTAL_BORDER_RIGHT:
		
			CMP AX,320
			JNG CHECK_HORIZANTAL_BORDER_LEFT
			MOV AX,3
			MOV BALL_X,AX
			JMP MOVE_BALL_HORIZANTAL_FINISH
			
		CHECK_HORIZANTAL_BORDER_LEFT:
			
			CMP AX,0
			JNL MOVE_BALL_HORIZANTAL_FINISH
			MOV AX,318
			MOV BALL_X,AX
			
			
		MOVE_BALL_HORIZANTAL_FINISH:
			RET
		
	MOVE_BALL_HORIZANTAL ENDP
	;-------------------------------------------------------------------- A FUNCTION TO MOVE THE BALL ---------------------------------------------------------
	
	MOVE_BALL_VERTICAL PROC
	
	
		; The following code is written in assembly programming language
		; This section moves the ball object vertically depending on its velocity and acceleration direction

		CMP ACCELERATION_DIRECTION,0        ; Compare acceleration direction with 0
		JE DOWN                             ; If acceleration direction is downwards, then jump to DOWN label
		JMP UP                              ; Else, jump to UP label

		DOWN:                               ; DOWN label for handling ball movement when the acceleration direction is downwards
			MOV AX,BALL_Y               ; Move the current y-coordinate of ball object to AX register
			ADD AX,BALL_VELOCITY_Y      ; Add the velocity of ball object to the y-coordinate
			MOV BALL_Y,AX               ; Set the new y-coordinate of ball object
			MOV AX,BALL_ACCELERATION_COUNTDOWN   ; Read the value of acceleration countdown into AX register
			CMP AX,0                            ; Compare acceleration countdown with 0
			JE ACCELERATE                       ; If acceleration countdown is 0, then jump to ACCELERATE label
			DEC AX                              ; Decrement the acceleration countdown by 1
			MOV BALL_ACCELERATION_COUNTDOWN,AX  ; Update the value of acceleration countdown
			JMP MOVE_BALL_VERTICAL_FINISH       ; Jump to MOVE_BALL_VERTICAL_FINISH label
		ACCELERATE:                     ; ACCELERATE label for accelerating ball object when acceleration countdown reaches 0
			MOV AX,5                   ; Reset the countdown value to 10
			MOV BALL_ACCELERATION_COUNTDOWN,AX  
			MOV AX,BALL_VELOCITY_Y      ; Move the current velocity of ball object to AX register
			ADD AX,BALL_ACCELERATION    ; Add the acceleration value to the velocity of ball object
			MOV BALL_VELOCITY_Y,AX      ; Set the new velocity of ball object
			JMP MOVE_BALL_VERTICAL_FINISH   ; Jump to MOVE_BALL_VERTICAL_FINISH label
			
		UP:                                 ; UP label for handling ball movement when the acceleration direction is upwards
			MOV AX,BALL_Y               ; Move the current y-coordinate of ball object to AX register
			SUB AX,BALL_VELOCITY_Y      ; Subtract the velocity of ball object from the y-coordinate
			MOV BALL_Y,AX               ; Set the new y-coordinate of ball object
			MOV AX,BALL_ACCELERATION_COUNTDOWN   ; Read the value of acceleration countdown into AX register
			CMP AX,0                            ; Compare acceleration countdown with 0
			JE DEACCELARATE                     ; If acceleration countdown is 0, then jump to DEACCELERATE label
			DEC AX                              ; Decrement the acceleration countdown by 1
			MOV BALL_ACCELERATION_COUNTDOWN,AX  ; Update the value of acceleration countdown
			JMP MOVE_BALL_VERTICAL_FINISH       ; Jump to MOVE_BALL_VERTICAL_FINISH label
		DEACCELARATE:                   ; DEACCELERATE label for decelerating ball object when acceleration countdown reaches 0
			MOV AX,5                   ; Reset the countdown value to 10
			MOV BALL_ACCELERATION_COUNTDOWN,AX  
			MOV AX,BALL_VELOCITY_Y      ; Move the current velocity of ball object to AX register
			SUB AX,BALL_ACCELERATION    ; Subtract the acceleration value from the velocity of ball object
			MOV BALL_VELOCITY_Y,AX      ; Set the new velocity of ball object
			CMP BALL_VELOCITY_Y,0       ; Compare the velocity of ball object with 0
			JNE MOVE_BALL_VERTICAL_FINISH       ; If velocity is not zero, jump to MOVE_BALL_VERTICAL_FINISH label
			MOV AX,0                    ; Reset the acceleration direction
			MOV ACCELERATION_DIRECTION,AX   
			MOV AX,1                    ; Set the velocity of ball object to 1
			MOV BALL_VELOCITY_Y,AX      
			MOV COIL_ACTIVE,0           ; Reset the status of coil - inactive
			JMP MOVE_BALL_VERTICAL_FINISH       ; Jump to MOVE_BALL_VERTICAL_FINISH label

		MOVE_BALL_VERTICAL_FINISH:      ; MOVE_BALL_VERTICAL_FINISH label for finishing the movement equation and return
			RET

			
	
	MOVE_BALL_VERTICAL ENDP
	
	;----------------------------------------------------------------- a function to move a platform -----------------------------------------------------------
		
	; Move the active platform based on the current acceleration direction and ball velocity.
	MOVE_PLATFORM PROC
		
		MOV INACTIVE_MOVED,1
		; Check if the acceleration direction is zero.
		CMP ACCELERATION_DIRECTION, 0
		JE FINISH_MOVE_PLATFORM

		; Check if the active platform is the left platform.
		CMP ACTIVE_PLATFORM, 1
		JE RIGHT_PLATFORM_IS_MOVING
		
		; Move the left platform up by adding the ball velocity to its y-coordinate.
		MOV AX, LEFT_PLATFORM_Y
		ADD AX, BALL_VELOCITY_Y
		ADD AX,ADD_TO_BALL_VELOCITY
		CMP COIL_ACTIVE,0
		JE COIL_NOT_ACTIVE_LEFT
		ADD AX,COIL_VELOCITY
		COIL_NOT_ACTIVE_LEFT:
			MOV LEFT_PLATFORM_Y, AX
			MOV ACTIVE_PLATFORM_Y, AX
			JMP ACTIVE_PLATFORM_BORDER_CHECK
			
		RIGHT_PLATFORM_IS_MOVING:
			; Move the right platform up by adding the ball velocity to its y-coordinate.
			MOV AX, RIGHT_PLATFORM_Y
			ADD AX, BALL_VELOCITY_Y
			ADD AX,ADD_TO_BALL_VELOCITY
			CMP COIL_ACTIVE,0
			JE COIL_NOT_ACTIVE_RIGHT
			ADD AX,COIL_VELOCITY
			COIL_NOT_ACTIVE_RIGHT:
				MOV RIGHT_PLATFORM_Y, AX
				MOV ACTIVE_PLATFORM_Y, AX
			
		ACTIVE_PLATFORM_BORDER_CHECK:
			
			MOV AX,BOTTOM_BORDER_Y
			CMP AX,ACTIVE_PLATFORM_Y
			; If the value in AX register is greater than the value of ACTIVE_PLATFORM_Y, 
			; jump to BROKEN_PLATFORM_IS_MOVING label
			JG BROKEN_PLATFORM_IS_MOVING
			MOV CHANGE_ACCELERATION,0
			CALL COLLISION
			

		BROKEN_PLATFORM_IS_MOVING:
			; Check if the broken platform is active.
			CMP BROKEN_PLATFORM_ACTIVE, 0
			JE COIL_PLATFORM_IS_MOVING
			; Move the broken platform up by adding the ball velocity to its y-coordinate.
			MOV AX, BROKEN_PLATFORM_Y
			ADD AX, BALL_VELOCITY_Y
			ADD AX,ADD_TO_BALL_VELOCITY
			CMP COIL_ACTIVE,0
			JE COIL_NOT_ACTIVE_BROKEN
			ADD AX,COIL_VELOCITY
			COIL_NOT_ACTIVE_BROKEN:
				MOV BROKEN_PLATFORM_Y, AX
				; Check if the broken platform has reached the bottom border.
				CMP AX, BOTTOM_BORDER_Y
				JL COIL_PLATFORM_IS_MOVING
				; Set BROKEN_PLATFORM_IS_DESTROYED to true.
				MOV BROKEN_PLATFORM_IS_DESTROYED, 1
			
		COIL_PLATFORM_IS_MOVING:
			; Check if the broken platform is active.
			CMP COIL_PLATFORM_ACTIVE, 0
			JE FINISH_MOVE_PLATFORM
			; Move the broken platform up by adding the ball velocity to its y-coordinate.
			MOV AX, COIL_PLATFORM_Y
			ADD AX, BALL_VELOCITY_Y
			ADD AX,ADD_TO_BALL_VELOCITY
			CMP COIL_ACTIVE,0
			JE COIL_NOT_ACTIVE_COIL
			ADD AX,COIL_VELOCITY
			COIL_NOT_ACTIVE_COIL:
				MOV COIL_PLATFORM_Y, AX
				; Check if the broken platform has reached the bottom border.
				CMP AX, BOTTOM_BORDER_Y
				JL FINISH_MOVE_PLATFORM
				; Set BROKEN_PLATFORM_IS_DESTROYED to true.
				MOV COIL_PLATFORM_IS_DESTROYED, 1
			
		INACTIVE_PLATFORM_IS_ACTIVE:	
		
			MOV INACTIVE_MOVED,0
			CMP INACTIVE_PLATFORM_MOVING,0
			JE FINISH_MOVE_PLATFORM
			
			MOV AX,INACTIVE_PLATFORM_Y
			ADD AX,BALL_VELOCITY_Y
			ADD AX,ADD_TO_BALL_VELOCITY
			
			MOV INACTIVE_PLATFORM_Y,AX
			CMP ACTIVE_PLATFORM,0
			JE RIGHT_PLATFORM_IS_INACTIVE
			
			MOV LEFT_PLATFORM_Y,AX
			MOV INACTIVE_PLATFORM_Y,AX
			JMP CHECK_BOTTOM_BORDER_FOR_INACTIVE_PLATFORM
			
			RIGHT_PLATFORM_IS_INACTIVE:
			
				MOV RIGHT_PLATFORM_Y,AX
				MOV INACTIVE_PLATFORM_Y,AX
				
			CHECK_BOTTOM_BORDER_FOR_INACTIVE_PLATFORM:
				
				MOV AX,BOTTOM_BORDER_Y
				CMP AX,INACTIVE_PLATFORM_Y
				JG FINISH_MOVE_PLATFORM
				MOV INACTIVE_PLATFORM_DESTROYED,1
			
		

		; The following code finishes moving a platform
		FINISH_MOVE_PLATFORM:
			
			; Compare the value of INACTIVE_MOVED with 0 and jump to CHECK_IF_THERE_IS_AN_ACTIVE_PLATFORM if they are equal 
			CMP INACTIVE_MOVED,0 
			JE CHECK_IF_THERE_IS_AN_ACTIVE_PLATFORM
			
			; Compare the value of INACTIVE_PLATFORM_MOVING with 0 and jump to CHECK_IF_THERE_IS_AN_ACTIVE_PLATFORM if they are equal
			CMP INACTIVE_PLATFORM_MOVING,0
			JE CHECK_IF_THERE_IS_AN_ACTIVE_PLATFORM

			; Move the inactive platform up by four units
			MOV AX,INACTIVE_PLATFORM_Y
			INC AX
			INC AX
			INC AX
			INC AX
			
			; Update the value of INACTIVE_PLATFORM_Y to reflect the new position
			MOV INACTIVE_PLATFORM_Y,AX
			
			; Compare the value of ACTIVE_PLATFORM with 0 and jump to RIGHT_PLATFORM_IS_INACTIVE2 if they are equal
			CMP ACTIVE_PLATFORM,0
			JE RIGHT_PLATFORM_IS_INACTIVE2
			
			; Update the position of LEFT_PLATFORM_Y and INACTIVE_PLATFORM_Y to match the new position
			MOV LEFT_PLATFORM_Y,AX
			MOV INACTIVE_PLATFORM_Y,AX
			
			; Jump to CHECK_BOTTOM_BORDER_FOR_INACTIVE_PLATFORM2
			JMP CHECK_BOTTOM_BORDER_FOR_INACTIVE_PLATFORM2
			
		RIGHT_PLATFORM_IS_INACTIVE2:
			
			; Update the position of RIGHT_PLATFORM_Y and INACTIVE_PLATFORM_Y to match the new position
			MOV RIGHT_PLATFORM_Y,AX
			MOV INACTIVE_PLATFORM_Y,AX
			
		CHECK_BOTTOM_BORDER_FOR_INACTIVE_PLATFORM2:

			; Compare the value of BOTTOM_BORDER_Y and INACTIVE_PLATFORM_Y and jump to CHECK_IF_THERE_IS_AN_ACTIVE_PLATFORM if the value of BOTTOM_BORDER_Y is greater than INACTIVE_PLATFORM_Y
			MOV AX,BOTTOM_BORDER_Y
			CMP AX,INACTIVE_PLATFORM_Y
			JG CHECK_IF_THERE_IS_AN_ACTIVE_PLATFORM
			
			; Set the value of INACTIVE_PLATFORM_DESTROYED to 1 if the inactive platform has hit the bottom border
			MOV INACTIVE_PLATFORM_DESTROYED,1

				
		; The following code checks if there is an active platform and moves it in the appropriate direction
		CHECK_IF_THERE_IS_AN_ACTIVE_PLATFORM:
			
			; Compare the value of ACCELERATION_DIRECTION with 1 and jump to FINISHED if they are equal 
			CMP ACCELERATION_DIRECTION,1
			JE FINISHED
			
			; Move the active platform up by 5 units if it has not hit a maximum height of 150 units 
			MOV AX,ACTIVE_PLATFORM_Y
			CMP AX,150
			JG FINISHED
			
			; Check the value of ACTIVE_PLATFORM and move the left or right platform up by 5 units depending on its value
			CMP ACTIVE_PLATFORM,1
			JE RIGHT_PLATFORM_SHOULD_MOVE
			MOV AX,LEFT_PLATFORM_Y
			ADD AX,5
			MOV LEFT_PLATFORM_Y,AX
			MOV ACTIVE_PLATFORM_Y,AX
			
			; Jump to FINISHED
			JMP FINISHED
				
		RIGHT_PLATFORM_SHOULD_MOVE:
			
			; Move the right platform up by 5 units and update the value of ACTIVE_PLATFORM_Y
			MOV AX,RIGHT_PLATFORM_Y
			ADD AX,5
			MOV RIGHT_PLATFORM_Y,AX
			MOV ACTIVE_PLATFORM_Y,AX
			
		FINISHED:
			; Return control to the calling function
			RET

	MOVE_PLATFORM ENDP
	
	
	INSECT_HANDLER PROC
		
		CMP INSECT_DESTROYED,1
		JE DESTROY_INSECT
		CMP INSECT_ACTIVE,0
		JE INSECT_IS_NOT_ACTIVE
		
		MOV AX,INSECT_X
		MOV PREV_INSECT_X,AX
		MOV AX,INSECT_Y
		MOV PREV_INSECT_Y,AX
		
		INSECT_IS_ACTIVE:
		
			CALL CHECK_INSECT_COLLISION
			INC INSECT_ERASE
			CALL DRAW_INSECT
			CALL MOVE_INSECT
			DEC INSECT_ERASE
			CALL DRAW_INSECT
			CALL CHECK_INSECT_COLLISION
			CALL CHECK_BORDERS_FOR_INSECT
			JMP INSECT_HANDLER_FINISH
			
		INSECT_IS_NOT_ACTIVE:
		
			MOV AH, 2CH
			INT 21H

			; Divide the milliseconds by 2 and check if the remainder is equal to 1.
			MOV BX, 2
			MOV AL, DL
			MOV AH, 0
			MOV DX, 0
			DIV BX
			CMP AX, 1
			; If the remainder is not equal to 1, jump to the end of the handler.
			JNE INSECT_HANDLER_FINISH
			; Set BROKEN_PLATFORM_ACTIVE to true.
			MOV INSECT_ACTIVE, 1
			; Jump to the end of the handler.
			JMP INSECT_HANDLER_FINISH
		
		DESTROY_INSECT:
			MOV AX,INSECT_X
			MOV PREV_INSECT_X,AX
			MOV AX,INSECT_Y
			MOV PREV_INSECT_Y,AX
			
			INC INSECT_ERASE
			CALL DRAW_INSECT
			DEC INSECT_ERASE
			MOV INSECT_X,20
			MOV INSECT_Y,-15
			MOV INSECT_DESTROYED,0
			MOV INSECT_ACTIVE,0
			JMP INSECT_HANDLER_FINISH
			
		INSECT_HANDLER_FINISH:
			RET
	INSECT_HANDLER ENDP
	;----------------------------------------------------------------- a function to draw the insect -----------------------------------------------------------
	DRAW_INSECT PROC
	
		CMP INSECT_ERASE,1
		JE INSECT_IS_TO_ERASED
		; Moves the variables BALL_X and BALL_Y into registers CX and DX, respectively, which hold the position of the ball to be drawn.
		MOV CX,INSECT_X
		MOV DX,INSECT_Y
		MOV INSECT_COLOR,05H
		JMP SET_CURRENT_INSECT
		
		INSECT_IS_TO_ERASED:
			MOV CX,PREV_INSECT_X
			MOV DX,PREV_INSECT_Y
			MOV INSECT_COLOR,00H
		
		SET_CURRENT_INSECT:
			MOV CURRENT_INSECT_X,CX
			MOV CURRENT_INSECT_Y,DX
		; The following block of code uses a loop with an inner loop to draw the ball horizontally and vertically:
		DRAW_INSECT_HORIZONTAL:

			; Set up the BIOS video services interrupt to display a pixel in the foreground color at the specified position (in registers CX and DX).
			MOV AH,0CH
			MOV AL,INSECT_COLOR
			MOV BH,00H 
			
			CMP DX,0
			JG DRAW_INSECT_INTERRUPT
			MOV AL,00H
			DRAW_INSECT_INTERRUPT:
				INT 10H ; Invoke the BIOS video services to display the pixel.
			
			
			INC CX ; Move the ball one pixel to the right by incrementing register CX.
			
			; Calculate the difference between the current X coordinate and the original X position of the ball, and compare it to the radius of the ball (stored in BALL_RADUIS). 
			;This determines whether the loop should continue or exit.
			MOV AX,CX
			SUB AX,CURRENT_INSECT_X
			CMP AX,INSECT_SIZE
			JNG DRAW_INSECT_HORIZONTAL ; The above steps repeat until the ball has been drawn completely horizontally, at which point the program jumps to the next section of code using JNG
			
			; Reset the X coordinate of the ball and move down one row by incrementing DX.
			MOV CX,CURRENT_INSECT_X
			INC DX
			
			; Calculate the difference between the current Y coordinate and the original Y position of the ball, and compare it to the radius of the ball. This determines whether the loop should continue 
			;or exit.
			MOV AX,DX
			SUB AX,CURRENT_INSECT_Y
			CMP AX,INSECT_SIZE
			JNG DRAW_INSECT_HORIZONTAL ; The above steps repeat until the ball has been drawn completely vertically, at which point the procedure returns using RET.
			
		RET
	DRAW_INSECT ENDP
	;----------------------------------------------------------------- a function to move the insect -----------------------------------------------------------
	; This procedure moves the insect and ball in the game
	MOVE_INSECT PROC

		; Check if insect is active, if not, jump to MOVE_INSECT_FINISH label
		CMP INSECT_ACTIVE,0
		JE MOVE_INSECT_FINISH
			
		; Move the insect in the X direction according to its velocity and update its X coordinate
		MOV AX,INSECT_X
		ADD AX,INSECT_VELOCITY
		MOV INSECT_X,AX
		
		; Check if the ball's acceleration direction is 0, if yes, jump to MOVE_INSECT_FINISH label
		CMP ACCELERATION_DIRECTION,0
		JE MOVE_INSECT_FINISH
		
		; Move the ball in the Y direction with velocity BALL_VELOCITY_Y by decreasing it by 1 and update its Y coordinate
		MOV AX,INSECT_Y
		ADD AX,BALL_VELOCITY_Y
		DEC AX
		CMP COIL_ACTIVE,0
		JE MOVE_INSECTE_COIL
		ADD AX,COIL_VELOCITY
		MOVE_INSECTE_COIL:
			MOV INSECT_Y,AX
		
		; Return from the procedure
		MOVE_INSECT_FINISH:
		RET
	MOVE_INSECT ENDP

	
	;----------------------------------------------------------------- a function to check borders for the insect -----------------------------------------------------------
	; This procedure checks if the insect has reached any of the borders and takes necessary actions.
	CHECK_BORDERS_FOR_INSECT PROC

		; Move the X-coordinate of the insect to AX register
		MOV AX,INSECT_X
		
		; Subtract the right border's X-coordinate from the insect's X-coordinate and compare it with -15
		SUB AX,RIGHT_BORDER_X
		CMP AX,-15
		
		; Jump to REVERSE_SPEED if the comparison result is greater than or equal to  -15
		JGE REVERSE_SPEED
			
		; Move the X-coordinate of the insect to AX register
		MOV AX,INSECT_X
		
		; Subtract the left border's X-coordinate from the insect's X-coordinate and compare it with 15
		SUB AX,LEFT_BORDER_X
		CMP AX,15
		
		; Jump to REVERSE_SPEED if the comparison result is less than or equal to 15
		JLE REVERSE_SPEED
		
		; Move the Y-coordinate of the insect to AX register and compare it with bottom border's Y coordinate
		MOV AX,INSECT_Y
		ADD AX,5
		CMP AX,BOTTOM_BORDER_Y
		
		; If the comparison result shows that the insect is below the bottom border, set INSECT_DESTROYED to 1 and jump to CHECK_BORDERS_FOR_INSECT_FINISH label 
		JLE CHECK_BORDERS_FOR_INSECT_FINISH
		MOV INSECT_DESTROYED,1
		JMP CHECK_BORDERS_FOR_INSECT_FINISH
		
		; If any of the border conditions are met, this block will reverse the speed and jump to CHECK_BORDERS_FOR_INSECT_FINISH label
		REVERSE_SPEED:
			MOV AX,INSECT_VELOCITY
			NEG AX
			MOV INSECT_VELOCITY,AX
			JMP CHECK_BORDERS_FOR_INSECT_FINISH
		
		; Return from the procedure
		CHECK_BORDERS_FOR_INSECT_FINISH:
		RET
	CHECK_BORDERS_FOR_INSECT ENDP

	;-----------------------------------------------------------------------------------------------------------------------------------------
		; This is a procedure called CHECK_COLLISION.
	CHECK_INSECT_COLLISION PROC
	
		
		; Move the value of BALL_X into AX register and add BALL_RADUIS to it
		MOV AX, BALL_X
		ADD AX, BALL_RADUIS
		CMP AX, INSECT_X ; Compare the value in AX register with the value of INSECT_X
		JNG NO_INSECT_COLLISION ; Jump to NO_INSECT_COLLISION if AX is not greater than or equal to INSECT_X


		; Move the value of INSECT_X into AX register and add INSECT_SIZE to it
		MOV AX, INSECT_X
		ADD AX, INSECT_SIZE
		CMP BALL_X, AX ; Compare the value of BALL_X with the value in AX register
		JNL NO_INSECT_COLLISION ; Jump to NO_INSECT_COLLISION if BALL_X is not less than or equal to AX


		; Move the value of BALL_Y into AX register and add BALL_RADUIS and 5 to it
		MOV AX, BALL_Y
		ADD AX, BALL_RADUIS
		ADD AX, 5
		CMP AX, INSECT_Y ; Compare the value in AX register with the value of INSECT_Y
		JNG NO_INSECT_COLLISION ; Jump to NO_INSECT_COLLISION if AX is not greater than or equal to INSECT_Y


		; Move the value of INSECT_Y into AX register and add INSECT_SIZE to it
		MOV AX, INSECT_Y
		ADD AX, INSECT_SIZE	
		CMP BALL_Y, AX ; Compare the value of BALL_Y with the value in AX register
		JNL NO_INSECT_COLLISION ; Jump to NO_INSECT_COLLISION if BALL_Y is not less than or equal to AX


		MOV IS_GAME_ACTIVE, 0 ; Set IS_GAME_ACTIVE to 0 if there is a collision
		; Label to indicate that there is no collision
		NO_INSECT_COLLISION:
		RET

		
	; End of the CHECK_COLLISION procedure
	CHECK_INSECT_COLLISION ENDP
	;----------------------------------------------------------------- a function to draw a platform -----------------------------------------------------------
	
	DRAW_PLATFORM PROC
		
		;This code sets the x and y coordinates for the platform that is going to be drawn,
		;depending on the value of TO_DRAW.
		SET_X_AND_Y:

			;Compare the value of TO_DRAW with 1, if it is equal jump to DRAW_RIGHT_PLATFORM
			CMP TO_DRAW,1
			JE DRAW_RIGHT_PLATFORM
			;Compare the value of TO_DRAW with 2, If it is equal jump to DRAW_BROKEN_PLATFORM
			CMP TO_DRAW,2
			JE DRAW_BROKEN_PLATFORM
			;Compare the value of TO_DRAW with 3, If it is equal jump to DRAW_COIL_PLATFORM
			CMP TO_DRAW,3
			JE DRAW_COIL_PLATFORM
			;If none of the conditions are met, initialize everything with default values
			MOV AX,LEFT_PLATFORM_X
			MOV DRAW_PLATFORM_X,AX
			MOV AX,LEFT_PLATFORM_Y
			MOV DRAW_PLATFORM_Y,AX
			JMP Initialize
			
		DRAW_RIGHT_PLATFORM:

			;If TO_DRAW is equal to 1 this section will set the coordinates for a right platform
			MOV AX,RIGHT_PLATFORM_X
			MOV DRAW_PLATFORM_X,AX
			MOV AX,RIGHT_PLATFORM_Y
			MOV DRAW_PLATFORM_Y,AX
			JMP Initialize

		DRAW_BROKEN_PLATFORM:
			;If TO_DRAW is equal to 2 this section will set the coordinates for a broken platform
			MOV AX,BROKEN_PLATFORM_X
			MOV DRAW_PLATFORM_X,AX
			MOV AX,BROKEN_PLATFORM_Y
			MOV DRAW_PLATFORM_Y,AX
			JMP Initialize

		DRAW_COIL_PLATFORM:
			;If TO_DRAW is equal to 3 this section will set the coordinates for a coil platform
			MOV AX,COIL_PLATFORM_X
			MOV DRAW_PLATFORM_X,AX
			MOV AX,COIL_PLATFORM_Y
			MOV DRAW_PLATFORM_Y,AX
			JMP Initialize	
		; Initialize CX and DX registers with the X and Y values of the platform
		Initialize:
			MOV CX,DRAW_PLATFORM_X
			MOV DX,DRAW_PLATFORM_Y
		
		; Create a loop to draw the left side of the platform horizontally
		DRAW_PLATFORM_HORIZONTAL:
			; Set AH to 0C (video mode), AL to 0F (light gray color), and BH to 00 for the background color
			MOV AH,0CH
			MOV AL,0FH
			MOV BH,00H
			;This code sets the color of the platform that is going to be drawn,
			;depending on the value of TO_DRAW
				;Compare the value of TO_DRAW with 3, if it is equal jump to COIL_PLATFORM_COLOR
				CMP TO_DRAW,3
				JE COIL_PLATFORM_COLOR
				;Compare the value of TO_DRAW with 2, If it is not equal jump to ACTIVE_COLOR
				CMP TO_DRAW,2
				JNE ACTIVE_COLOR
				;If TO_DRAW is equal to 2 this section will set the color for a broken platform
				BROKEN_PLATFORM_COLOR:
					MOV AL,0CH
					JMP ACTIVE_COLOR
				;If TO_DRAW is equal to 3 this section will set the color for a coil platform
				COIL_PLATFORM_COLOR:
					MOV AL,0AH
					JMP ACTIVE_COLOR
				;Check if DX is greater than 0. 
				;If it is, jump to INTERRUPT, otherwise move 00H to AL and return.
				ACTIVE_COLOR:
					CMP DX,0
					JG INTERRUPT
					MOV AL,00H
				INTERRUPT:
					INT 10H ;Generate software interrupt 10H (BIOS video services) to set the color.
			; Increment CX, then calculate the value of AX by subtracting LEFT_PLATFORM_X from CX
			INC CX
			MOV AX,CX
			SUB AX,DRAW_PLATFORM_X
			; Compare the value of AX to PLATFORM_WIDTH. If it is less than or equal to PLATFORM_WIDTH, jump back to the DRAW_PLATFORM_LEFT_HORIZONTAL label
			CMP AX,PLATFORM_WIDTH
			JNG DRAW_PLATFORM_HORIZONTAL
			; Reset CX to the original X value of the platform, then increment DX by 1
			MOV CX,DRAW_PLATFORM_X
			INC DX
			; Calculate the value of AX by subtracting DRAW_PLATFORM_Y from DX, then compare it with PLATFORM_HEIGHT. If it is less than or equal to PLATFORM_HEIGHT, jump back to the DRAW_PLATFORM_LEFT_HORIZONTAL label
			MOV AX,DX
			SUB AX,DRAW_PLATFORM_Y
			CMP AX,PLATFORM_HEIGHT
			JNG DRAW_PLATFORM_HORIZONTAL
		; Return control to the calling procedure
		RET	
	; End of the DRAW_PLATFORM procedure
	DRAW_PLATFORM ENDP

	
	
	;----------------------------------------------------------------- a function to check for collision -----------------------------------------------------------
	CHECK_COLLISION PROC
	
		CMP COIL_ACTIVE,1
		JE NO_COLLISION
		
		CMP ACCELERATION_DIRECTION,1
		JE NO_COLLISION
		
		CMP ACTIVE_PLATFORM,3
		JE CHECK
		
		CMP ACTIVE_PLATFORM,2
		JE CHECK
		
		CMP ACTIVE_PLATFORM,1
		JE RIGHT_IS_ACTIVE
		
		MOV AX,LEFT_PLATFORM_X
		MOV ACTIVE_PLATFORM_X,AX
		MOV AX,LEFT_PLATFORM_Y
		MOV ACTIVE_PLATFORM_Y,AX
		JMP CHECK
		
		RIGHT_IS_ACTIVE:
			MOV AX,RIGHT_PLATFORM_X
			MOV ACTIVE_PLATFORM_X,AX
			MOV AX,RIGHT_PLATFORM_Y
			MOV ACTIVE_PLATFORM_Y,AX
			JMP CHECK
		CHECK:
		; Calculate the value of AX by adding BALL_X and BALL_RADUIS, then compare it to LEFT_PLATFORM_X. If it is less than or equal to LEFT_PLATFORM_X, jump to NO_COLLISION label
		MOV AX,BALL_X
		ADD AX,BALL_RADUIS
		CMP AX,ACTIVE_PLATFORM_X
		JNG NO_COLLISION
		
		
		; Calculate the value of AX by adding LEFT_PLATFORM_X and PLATFORM_WIDTH, then compare BALL_X to AX. If BALL_X is greater than or equal to AX, jump to NO_COLLISION label
		MOV AX,ACTIVE_PLATFORM_X
		ADD AX,PLATFORM_WIDTH
		CMP BALL_X,AX
		JNL NO_COLLISION
		
		; Calculate the value of AX by adding BALL_Y, BALL_RADUIS, and 5, then compare it to LEFT_PLATFORM_Y. If it is less than or equal to LEFT_PLATFORM_Y, jump to NO_COLLISION label
		MOV AX,BALL_Y
		ADD AX,BALL_RADUIS
		ADD AX,5
		CMP AX,ACTIVE_PLATFORM_Y
		JNG NO_COLLISION
		
		; Calculate the value of AX by adding LEFT_PLATFORM_Y and PLATFORM_HEIGHT, then compare BALL_Y to AX. If BALL_Y is greater than or equal to AX, jump to NO_COLLISION label
		MOV AX,ACTIVE_PLATFORM_Y
		ADD AX,PLATFORM_HEIGHT	
		CMP BALL_Y,AX
		JNL NO_COLLISION
		
		CMP ACTIVE_PLATFORM,2
		JE CHECK_FOR_BROKEN_PLATFORM_COLLISION
		
		CMP ACTIVE_PLATFORM,3
		JE CHECK_FOR_COIL_PLATFORM_COLLISION
		; Call the COLLISION procedure if no collisions were detected
		MOV CHANGE_ACCELERATION,1
		CALL COLLISION
		JMP NO_COLLISION
		
		
		CHECK_FOR_BROKEN_PLATFORM_COLLISION:
		
			MOV BROKEN_PLATFORM_IS_DESTROYED,1
			JMP NO_COLLISION
			
		CHECK_FOR_COIL_PLATFORM_COLLISION:
		
			MOV COIL_PLATFORM_IS_DESTROYED,1
			MOV CHANGE_ACCELERATION,2
			MOV COIL_ACTIVE,1
			CALL COLLISION
			JMP NO_COLLISION
			
		; Return control to the calling procedure
		NO_COLLISION:
			RET
		
	; End of the CHECK_COLLISION procedure
	CHECK_COLLISION ENDP
	
	
	;----------------------------------------------------------------- a function to make a beep sound -----------------------------------------------------------
	MAKE_SOUND PROC
		IN AL,61H
		OR AL,03H
		OUT 61H,AL ; Turn ON system speaker
		MOV AL,0B6H ; program Counter 2
		OUT 43H,AL
		MOV BX,300
		MOV AX,34DCH
		MOV DX,12H
		DIV BX
		OUT 42H,AL ;set the frequency of counter 2 to 2000Hz
		MOV AL,AH
		OUT 42H,AL
		MOV CX,0FFFH
		BACK2:
		MOV DX,0FFFFH ; Delay
		BACK1:
		DEC DX
		JNZ BACK1
		;LOOP BACK2
		IN AL,61H
		XOR AL,03H ; Turn OFF system speaker
		OUT 61H,AL
		RET
	
	MAKE_SOUND ENDP
	;---------------------------------------------------- a function revert acceleration and change the  ------------------------------------------------------
	COLLISION PROC
		SOUND:
			CALL MAKE_SOUND
		; acceleration properies such as its direction and countdown gets changed
		CMP CHANGE_ACCELERATION,0
		JE CHANGE_ACTIVE_PLATFORM
		CHANGE_ACCELERATION_PROPERTIES:
			MOV AX,1 
			MOV ACCELERATION_DIRECTION,AX ; when collision happens ACCELERATION_DIRECTION is set to 1 which means is going up
			MOV AX,20
			MOV BALL_ACCELERATION_COUNTDOWN,AX ; BALL_ACCELERATION_COUNTDOWN gets a reset
			MOV AX,3
			MOV BALL_VELOCITY_Y,AX
			JMP CHANGE_ACTIVE_PLATFORM
		CHANGE_ACTIVE_PLATFORM: ;This section of code changes the active platform in the game. 
			CMP ACTIVE_PLATFORM,1 ;Compare the value of ACTIVE_PLATFORM with 1
			JE RIGHT_PLATFORM_IS_ACTIVE ;If equal to 1, jump to label RIGHT_PLATFORM_IS_ACTIVE
			;Move right platform and corresponding values to active variables
			MOV ACTIVE_PLATFORM,1
			MOV AX,RIGHT_PLATFORM_X
			MOV ACTIVE_PLATFORM_X,AX
			MOV AX,RIGHT_PLATFORM_Y
			MOV ACTIVE_PLATFORM_Y,AX
			MOV AX,LEFT_PLATFORM_X
			MOV INACTIVE_PLATFORM_X,AX
			MOV AX,LEFT_PLATFORM_Y
			MOV INACTIVE_PLATFORM_Y,AX
			JMP COLLISION_FINISH
			;Label for when right platform is already active
			RIGHT_PLATFORM_IS_ACTIVE:
				MOV ACTIVE_PLATFORM,0
				MOV AX,LEFT_PLATFORM_X
				MOV ACTIVE_PLATFORM_X,AX
				MOV AX,LEFT_PLATFORM_Y
				MOV ACTIVE_PLATFORM_Y,AX
				MOV AX,RIGHT_PLATFORM_X
				MOV INACTIVE_PLATFORM_X,AX
				MOV AX,RIGHT_PLATFORM_Y
				MOV INACTIVE_PLATFORM_Y,AX
				JMP COLLISION_FINISH	
		COLLISION_FINISH: ;Label for collision finish
			CMP CHANGE_ACCELERATION,2 ;Compare the value of CHANGE_ACCELERATION with 2
			JE COLLISION_FINISH2 ;If equal to 2, jump to label COLLISION_FINISH2
			;Set inactive platform moving to true and destroyed to false
			MOV INACTIVE_PLATFORM_MOVING,1
			MOV INACTIVE_PLATFORM_DESTROYED,0
		COLLISION_FINISH2:
			MOV CHANGE_ACCELERATION,0
			RET
	COLLISION ENDP
	
	INACTIVE_PLATFORM_HANDLER PROC
	
		CMP INACTIVE_PLATFORM_DESTROYED,1
		JNE INACTIVE_PLATFORM_HANDLER_FINISH
		PLATFORM_IS_DESTROYED:	
			
			MOV INACTIVE_PLATFORM_DESTROYED,0
			MOV INACTIVE_PLATFORM_MOVING,0
			; platform should be replaced
			; x and y of the next platform should be randomized
			RANDOMIZE_COORDINATES:
				MOV AH,2CH
				INT 21H    ; get system time interrupt
				CMP ACTIVE_PLATFORM,1
				JE RIGHT_IS_ACTIVE1
				MOV CX,150
				JMP GET_X
				RIGHT_IS_ACTIVE1:
					MOV CX,0
					; getting a random number between 25 and 300 for the X property of the platform
					; we can do that by multiplying dl by 3 and adding 25 to it if its less than 25 
					GET_X:
						MOV BL,3   ; set bl to 3 to be used in the mult
						MOV AL,DL  ; DL is 1/100 seconds
						MUL BL     ; AL * BL (1/100 * 3) which yields a number between 0 to 300 
						MOV BL,2
						DIV BL
						MOV BH,AL  ; BH stores the product of the multiplication
						MOV AH,0
						MOV BL,BH
						MOV BH,0
						ADD BX,CX
						CMP BX,25  ; if BH is greater than 25 then jump to GET_Y
						JGE GET_Y
						ADD BX,25 ; else add 25 to BH
					; we can do that by adding 140 to the remainder of dl/40
					GET_Y:
						MOV AL,DL
						MOV AH,AL
						MOV AH,0
						MOV DX,0
						MOV CX,20
						DIV CX
						MOV AX,DX
						ADD AX,5
						NEG AX
				; change x and y of the platform
				CHANGE_COORDINATES:
					SUB BX,15
					CMP ACTIVE_PLATFORM,1
					JE LEFT_PLATFORM_CHANGE
					
					MOV RIGHT_PLATFORM_X,BX
					MOV RIGHT_PLATFORM_Y,AX
					JMP SCORE_INCREMENT
					
					LEFT_PLATFORM_CHANGE:
						MOV LEFT_PLATFORM_X,BX
						MOV LEFT_PLATFORM_Y,AX
						JMP SCORE_INCREMENT
					
				SCORE_INCREMENT:
					MOV AX,SCORE
					INC AX
					MOV SCORE,AX
				
		INACTIVE_PLATFORM_HANDLER_FINISH:		
			RET
	
	INACTIVE_PLATFORM_HANDLER ENDP
	
	
	BROKEN_PLATFORM_HANDLER PROC
	
		
		CMP BROKEN_PLATFORM_IS_DESTROYED, 1 ; Compare the value of BROKEN_PLATFORM_IS_DESTROYED with 1.		
		JE DESTROY_BROKEN_PLATFORM ; Jump to DESTROY_BROKEN_PLATFORM if they are equal (i.e., BROKEN_PLATFORM_IS_DESTROYED is true).		
		CMP BROKEN_PLATFORM_ACTIVE, 0 ; Compare the value of BROKEN_PLATFORM_ACTIVE with 0.		
		JE BROKEN_PLATFORM_IS_NOT_ACTIVE ; Jump to BROKEN_PLATFORM_IS_NOT_ACTIVE if they are equal (i.e., BROKEN_PLATFORM_ACTIVE is false).


		; Checks if the broken platform is active.
		BROKEN_PLATFORM_IS_ACTIVE:
			; Save the current active platform's x, y and ID in AX, BX and CX respectively.
			MOV AX, ACTIVE_PLATFORM_X
			MOV BX, ACTIVE_PLATFORM_Y
			MOV CX, ACTIVE_PLATFORM
			; Set the ID of the active platform to 2 (broken).
			MOV ACTIVE_PLATFORM, 2

			; Push the values of AX, BX and CX onto the stack.
			PUSH AX
			PUSH BX
			PUSH CX

			; Set the active platform's x and y to the broken platform's x and y.
			MOV AX, BROKEN_PLATFORM_X
			MOV BX, BROKEN_PLATFORM_Y
			MOV ACTIVE_PLATFORM_X, AX
			MOV ACTIVE_PLATFORM_Y, BX

			; Call a function to check for collisions with the new active platform.
			CALL CHECK_COLLISION

			; Pop the original values of AX, BX and CX from the stack.
			POP CX
			POP BX
			POP AX

			; Set the values of the active platform's x, y and ID to their original values.
			MOV ACTIVE_PLATFORM_X, AX
			MOV ACTIVE_PLATFORM_Y, BX
			MOV ACTIVE_PLATFORM, CX

			; Jump to the end of the handler.
			JMP BROKEN_PLATFORM_HANDLER_FINISH

		
		; If the broken platform is not active, execute this code block.
		BROKEN_PLATFORM_IS_NOT_ACTIVE:
			; Call the system time interrupt to get the current time.
			MOV AH, 2CH
			INT 21H

			; Divide the milliseconds by 2 and check if the remainder is equal to 1.
			MOV BX, 2
			MOV AL, DL
			MOV AH, 0
			MOV DX, 0
			DIV BX
			CMP AX, 1
			; If the remainder is not equal to 1, jump to the end of the handler.
			JNE BROKEN_PLATFORM_HANDLER_FINISH
			; Set BROKEN_PLATFORM_ACTIVE to true.
			MOV BROKEN_PLATFORM_ACTIVE, 1
			; Jump to the end of the handler.
			JMP BROKEN_PLATFORM_HANDLER_FINISH

		; If the broken platform is destroyed, execute this code block.
		DESTROY_BROKEN_PLATFORM:
			; Set BROKEN_PLATFORM_IS_DESTROYED and BROKEN_PLATFORM_ACTIVE to false.
			MOV BROKEN_PLATFORM_IS_DESTROYED, 0
			MOV BROKEN_PLATFORM_ACTIVE, 0

			; Call the system time interrupt to get the current time.
			MOV AH, 2CH
			INT 21H

			; Calculate the new x and y coordinates of the broken platform.
			MOV BL, 3
			MOV AL, DL
			MUL BL
			MOV BH, AL
			MOV AH, 0
			MOV BL, BH
			MOV BH, 0
			ADD BX, 25

			MOV AL, DL
			MOV AH, AL
			MOV AH, 0
			MOV DX, 0
			MOV CX, 20
			DIV CX
			MOV AX, DX
			ADD AX, 20
			NEG AX

			; Set the new x and y coordinates of the broken platform.
			MOV BROKEN_PLATFORM_X, BX
			MOV BROKEN_PLATFORM_Y, AX
			; Jump to the end of the handler.
			JMP BROKEN_PLATFORM_HANDLER_FINISH

		BROKEN_PLATFORM_HANDLER_FINISH:
			; Return from the function.
			RET

			
	BROKEN_PLATFORM_HANDLER ENDP
	
		;------------------------------------------------------------------ A FUNCTION TO HANDLE THE COIL PLATFORM------------------------------------------------------
	COIL_PLATFORM_HANDLER PROC
	
		CMP COIL_PLATFORM_IS_DESTROYED, 1 ; Compare COIL_PLATFORM_IS_DESTROYED with 1 using the CMP instruction	
		JE DESTROY_COIL_PLATFORM ; Jump to DESTROY_COIL_PLATFORM if they are equal
		
		CMP COIL_PLATFORM_ACTIVE, 0 ; Compare COIL_PLATFORM_ACTIVE with 0 using the CMP instruction 		
		JE COIL_PLATFORM_IS_NOT_ACTIVE ; Jump to COIL_PLATFORM_IS_NOT_ACTIVE if they are equal		
		; Label to indicate that COIL_PLATFORM is active
		COIL_PLATFORM_IS_ACTIVE:
			; Move ACTIVE_PLATFORM_X into AX register and ACTIVE_PLATFORM_Y into BX register 
			MOV AX, ACTIVE_PLATFORM_X
			MOV BX, ACTIVE_PLATFORM_Y		
		; Move ACTIVE_PLATFORM into CX register and then set it to 3 
			MOV CX, ACTIVE_PLATFORM
			MOV ACTIVE_PLATFORM, 3
			; Push the values of AX, BX and CX onto the stack.
			PUSH AX
			PUSH BX
			PUSH CX
			; Move COIL_PLATFORM_X into AX register, and COIL_PLATFORM_Y into BX register 
			MOV AX, COIL_PLATFORM_X
			MOV BX, COIL_PLATFORM_Y
			; Move AX register value into ACTIVE_PLATFORM_X, and BX register value into ACTIVE_PLATFORM_Y 
			MOV ACTIVE_PLATFORM_X, AX
			MOV ACTIVE_PLATFORM_Y, BX
			CALL CHECK_COLLISION ; Call the function CHECK_COLLISION
			; Pop the values from the stack (in reverse order)
			POP CX
			POP BX
			POP AX
			; Move AX register value into ACTIVE_PLATFORM_X, BX register value into ACTIVE_PLATFORM_Y, CX register value into ACTIVE_PLATFORM
			MOV ACTIVE_PLATFORM_X, AX
			MOV ACTIVE_PLATFORM_Y, BX
			MOV ACTIVE_PLATFORM, CX
			JMP COIL_PLATFORM_HANDLER_FINISH ; Jump to the end of the handler.

		; Label to indicate that COIL_PLATFORM is not active
		COIL_PLATFORM_IS_NOT_ACTIVE:
			
			MOV AH, 2CH ; Set AH register to 2CH
			INT 21H ; Call interrupt 21H
			
			
			MOV BX, 20 ; Move 20 into BX register
			MOV AL, DL ; Move DL into AL register
			; Set AH register to 0 and DX register to 0
			MOV AH, 0
			MOV DX, 0
			DIV BX ; Divide AX by BX and the remainder is stored in DX
			
			CMP DX, 1 ; Compare DX with 1
			
			JNE COIL_PLATFORM_HANDLER_FINISH ; Jump to COIL_PLATFORM_HANDLER_FINISH if they are not equal			
			MOV COIL_PLATFORM_ACTIVE, 1 ; Set COIL_PLATFORM_ACTIVE to 1			
			JMP COIL_PLATFORM_HANDLER_FINISH ; Jump to COIL_PLATFORM_HANDLER_FINISH

		; Label to indicate that COIL_PLATFORM should be destroyed 
		DESTROY_COIL_PLATFORM:
			; Set COIL_PLATFORM_IS_DESTROYED and COIL_PLATFORM_ACTIVE to 0 
			MOV COIL_PLATFORM_IS_DESTROYED, 0
			MOV COIL_PLATFORM_ACTIVE, 0

			MOV AH, 2CH ; Set AH register to 2CH
			INT 21H ; Call interrupt 21H
	
			MOV BL, 3 ; Move 3 into BL register
			MOV AL, DL ; Move DL into AL register
			; Multiply AL by BL and store the result in BX register
			MUL BL
			MOV BH, AL
			; Set AH register to 0 and BL register to BH
			MOV AH, 0
			MOV BL, BH
			; Set BH register to 0 and add BX by 25 
			MOV BH, 0
			ADD BX, 25

			MOV AL, DL ; Move DL into AL register
			; Set AH register to 0 and DX register to 0
			MOV AH, 0
			MOV DX, 0
			; Set CX register to 20 and divide AX by CX. The remainder is stored in DX
			MOV CX, 20
			DIV CX
			MOV AX, DX
			ADD AX, 20
			NEG AX

			; Move BX register value into COIL_PLATFORM_X, and the negated AX register value into COIL_PLATFORM_Y  
			MOV COIL_PLATFORM_X, BX
			MOV COIL_PLATFORM_Y, AX
			; Jump to COIL_PLATFORM_HANDLER_FINISH
			JMP COIL_PLATFORM_HANDLER_FINISH

		; Label to indicate that the handler has finished
		COIL_PLATFORM_HANDLER_FINISH:
			RET

	COIL_PLATFORM_HANDLER ENDP
	;---------------------------------------------------- a function revert acceleration and change the  ------------------------------------------------------
	
	CHECK_BORDERS PROC
		; Check if the ball has collided with the top border. If it has, set ACCELERATION_DIRECTION to 0 and jump to CHECK_BOTTOM_BORDER label. Otherwise, continue to next instruction
		CHECK_TOP_BORDER:
			MOV AX,TOP_BORDER_Y
			SUB AX,BALL_Y
			CMP AX,-5
			JL CHECK_BOTTOM_BORDER
			MOV AX,0
			MOV ACCELERATION_DIRECTION,AX
			MOV COIL_ACTIVE,0
			
		; Check if the ball has collided with the bottom border. If it has, set IS_GAME_ACTIVE to 0 and jump to CHECK_BORDERS_FINISH label. Otherwise, continue to next instruction
		CHECK_BOTTOM_BORDER:
			MOV AX,BOTTOM_BORDER_Y
			SUB AX,BALL_Y
			CMP AX,5
			JG CHECK_BORDERS_FINISH
			MOV AL,0
			MOV IS_GAME_ACTIVE,AL
			
		; Return control to the calling procedure
		CHECK_BORDERS_FINISH:
			RET
			
	; End of the CHECK_BORDERS procedure
	CHECK_BORDERS ENDP
	
	;--------------------------------------------------------int to String procedure ------------------------------------------------------------
	; intToString - Convert integer `SCORE` to a string and store it in `BUFFER`

	intToString PROC FAR
			
		; Move the value of `SCORE` to register AX
		MOV AX,SCORE
		
		; Store the value of `AX` at memory location `LOCALVARS+2`
		MOV [LOCALVARS+2],AX
		
		; Check if `SCORE` is zero
		CMP AX,0
		JNE FIND_LEN
		
		; If score is zero, store '0' (ASCII 48) in `BUFFER`
		MOV [BUFFER],48
		
		; Set length of string to 1 and jump to endString
		MOV [LOCALVARS],1
		JMP endString
			
				
		FIND_LEN:
			
			; Compare score with 1000
			CMP AX,1000
			
			; If score >= 1000, set length of string to 4
			JGE MORE_THAN_1000
				
			; Else compare with 100
			CMP AX,100
			
			; If score >= 100, set length of string to 3
			JGE MORE_THAN_100
				
			; Else compare with 10
			CMP AX,10
			
			; If score >= 10, set length of string to 2
			JGE MORE_THAN_10
				
			; If score < 10, set length of string to 1
			MOV CX,1
			MOV [LOCALVARS],CX
			
			; Jump to DIGIT_TO_CHAR label
			JMP DIGIT_TO_CHAR
				
		MORE_THAN_1000:
				
				; If score >= 1000, set length of string to 4
				MOV CX,4
				MOV [LOCALVARS],CX
				
				; Jump to DIGIT_TO_CHAR label
				JMP DIGIT_TO_CHAR
				
		MORE_THAN_100:
				
				; If score >= 100, set length of string to 3
				MOV CX,3
				MOV [LOCALVARS],CX
				
				; Jump to DIGIT_TO_CHAR label
				JMP DIGIT_TO_CHAR
					
		MORE_THAN_10:
				
				; If score >= 10, set length of string to 2
				MOV CX,2
				MOV [LOCALVARS],CX
				
				; Jump to DIGIT_TO_CHAR label
				JMP DIGIT_TO_CHAR
			
		DIGIT_TO_CHAR:
		
			; Move the value `10` to register BX
			MOV BX,10
			
			; Move the value from memory location `LOCALVARS+2` to register AX
			MOV AX,[LOCALVARS+2]
			
			; Clear the register DX
			MOV DX,0
			
			; Divide AX by BX and store the quotient in AX and remainder in DX
			DIV BX
			
			; Store the quotient back to memory location `LOCALVARS+2`
			MOV [LOCALVARS+2],AX
			
			; Clear the high bits of DX
			MOV DH,0
			
			; Convert digit to its corresponding ASCII character
			ADD DL,48
			
			; Calculate index for current digit in the `BUFFER` using the length
			; of the string and store the digit at that index
			MOV BX,CX
			DEC BX
			MOV [buffer+BX],DL
			
			; Decrement length of the string by 1
			LOOP DIGIT_TO_CHAR
				
				
			endString: 
				
				; Return from procedure
				RET
			
	intToString ENDP 

	;--------------------------------------------------------print string procedure ------------------------------------------------------------
	; printString - Print the string in `BUFFER` to console

	printString PROC FAR
		
		; Get length of string from memory location `LOCALVARS`, move to register BX
		MOV BX,[LOCALVARS]
		
		; Append '$' at the end of the string
		MOV [buffer+BX],'$'
		
		; Use BIOS interrupt 10h to set video mode, cursor position and page
		MOV AH,02H      ; Set AH=2 for changing the cursor position
		MOV BH,00H      ; Set BH=0 for active display page
		MOV DH,3D       ; Set DH=row number (125)
		MOV DL,36D      ; Set DL=column number (54)
		INT 10H         ; Call BIOS interrupt 10h to set video mode, cursor position and page
		
		; Print the string at the current cursor position using DOS interrupt 21h
		MOV AH,09H      ; Set AH=9 for printing a string
		MOV DX,OFFSET buffer ; Set DX to the memory address of `BUFFER`
		INT 21h         ; Call DOS interrupt 21h to print the string
		
		; Return from procedure
		RET         
			
	printString ENDP     
	
	
; The following code is a procedure in Assembly Programming Language for displaying the game over screen

GAME_OVER_SCREEN PROC FAR

	; Call CLEAR_SCREEN procedure to clear the screen
	CALL CLEAR_SCREEN   ; This is most likely a custom-defined function

	; Call intToString procedure to convert an integer to a string and store it in buffer
	CALL intToString    ; This is most likely a custom-defined function
	MOV BX,[LOCALVARS]  ; Move the value of the local variable to BX register
	MOV [buffer+BX],'$' ; Add a null terminator to the end of buffer

	; Set up cursor position to row 10, column 15
	MOV AH,02H ; set function to move cursor 
	MOV BH,00H ; select page 0
	MOV DH,10D ; row position 
	MOV DL,15D ; column position 
	INT 10H   ; call BIOS video services 

	; Print "Game Over" text
	MOV AH,09H ; set function to print string 
	MOV DX,OFFSET GAME_OVER_TEXT ; load offset address of string
	INT 21h   ; call DOS interrupts 

	; Set up cursor position to row 12, column 15
	MOV AH,02H ; set function to move cursor 
	MOV BH,00H ; select page 0
	MOV DH,12D ; row position 
	MOV DL,15D ; column position 
	INT 10H   ; call BIOS video services 

	; Print "Score" text
	MOV AH,09H ; set function to print string 
	MOV DX,OFFSET SCORE_TEXT ; load offset address of string
	INT 21h   ; call DOS interrupts 

	; Set up cursor position to row 12, column 22
	MOV AH,02H ; set function to move cursor 
	MOV BH,00H ; select page 0
	MOV DH,12D ; row position 
	MOV DL,22D ; column position 
	INT 10H   ; call BIOS video services 

	; Print score stored in buffer
	MOV AH,09H ; set function to print string 
	MOV DX,OFFSET buffer ; load offset address of string
	INT 21h   ; call DOS interrupts 

	; Set up cursor position to row 16, column 8
	MOV AH,02H ; set function to move cursor 
	MOV BH,00H ; select page 0
	MOV DH,16D ; row position 
	MOV DL,8D ; column position 
	INT 10H   ; call BIOS video services 

	; Print "Restart Game" text
	MOV AH,09H ; set function to print string 
	MOV DX,OFFSET RESTART_GAME_TEXT ; load offset address of string
	INT 21h   ; call DOS interrupts 

	; Set up cursor position to row 18, column 8
	MOV AH,02H ; set function to move cursor 
	MOV BH,00H ; select page 0
	MOV DH,18D ; row position 
	MOV DL,8D ; column position 
	INT 10H   ; call BIOS video services 
	
	; Print "End Game" text
	MOV AH,09H ; set function to print string 
	MOV DX,OFFSET END_GAME_TEXT ; load offset address of string
	INT 21h   ; call DOS interrupts 
	
	RET ; Return from the procedure

GAME_OVER_SCREEN ENDP ; End of procedure

	
	
; The following code is a procedure in Assembly Programming Language for displaying the main menu of a game

MAIN_MENU_SCREEN PROC FAR

	; Set up cursor position
	MOV AH,02H ; set function to move cursor 
	MOV BH,00H ; select page 0
	MOV DH,10D ; row position 
	MOV DL,15D ; column position 
	INT 10H   ; call BIOS video services 

	; Print "Main Menu" text
	MOV AH,09H ; set function to print string 
	MOV DX,OFFSET MAIN_MENU_TEXT ; load offset address of string
	INT 21h   ; call DOS interrupts 

	; Set up position for "Start Game" text
	MOV AH,02H ; set function to move cursor 
	MOV BH,00H ; select page 0
	MOV DH,14D ; row position 
	MOV DL,8D ; column position 
	INT 10H   ; call BIOS video services 

	; Print "Start Game" text
	MOV AH,09H ; set function to print string 
	MOV DX,OFFSET START_GAME_TEXT ; load offset address of string
	INT 21h   ; call DOS interrupts 

	; Set up position for "End Game" text
	MOV AH,02H ; set function to move cursor 
	MOV BH,00H ; select page 0
	MOV DH,16D ; row position 
	MOV DL,8D ; column position 
	INT 10H   ; call BIOS video services 

	; Print "End Game" text
	MOV AH,09H ; set function to print string 
	MOV DX,OFFSET END_GAME_TEXT ; load offset address of string
	INT 21h   ; call DOS interrupts 
	
	RET ; Return from the procedure

MAIN_MENU_SCREEN ENDP ; End of procedure

CODE ENDS
END 