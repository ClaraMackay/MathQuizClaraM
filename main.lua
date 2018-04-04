-----------------------------------------------------------------------------------------
-- Title: LivesAndTimers
-- Name: Clara Mackay
-- Course: ICS2O/3C
-- This program asks a math question, if you get a question wrong you lose a life, 
-- and one of the 4 hearts disappear. 

-----------------------------------------------------------------------------------------------


-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- sets the background colour
display.setDefault("background", 16/255, 35/255, 104/255)

-----------------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------------

-- create local variables
local questionObject
local correctObject
local incorrectObject
local numericField
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local incorrectObject

-- variables for the points
local pointsObject
local points = 0

-- variables for the timer
local totalSeconds = 10
local secondsLeft = 10
local clockText 
local countDownTimer

-- variables for the lives
local lives = 4
local heart1
local heart2
local heart3
local heart4
local gameOver


-----------------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------------

local incorrectSound = audio.loadSound("Sounds/wrongSound.mp3")
local incorrectSoundChannel

local gameOverSound = audio.loadSound("Sounds/wrongSound.mp3")
local gameOverSoundChannel

-----------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------------

local function AskQuestion()
	-- generate 2 random numbers between max. and a min. number
	randomNumber1 = math.random (10, 20)
	randomNumber2 = math.random (10, 20)
	randomNumber3 = math.random (0, 10)
	randomNumber4 = math.random (0, 10)


	-- generate random number for the operator
	randomOperator = math.random(1, 3)

	if (randomOperator == 1) then
		--calculate the correct answer for addition
		correctAnswer = randomNumber1 + randomNumber2
		-- create question in text object for addition
		questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "


	elseif (randomOperator == 2) then
		--calculate the correct answer for subtraction
		correctAnswer = randomNumber1 - randomNumber2
		-- create question in text object for subtraction
		questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "
		

	elseif (randomOperator == 3) then
		--calculate the correct answer for multiplication
		correctAnswer = randomNumber3 * randomNumber4
		-- create question in text object for multiplication
		questionObject.text = randomNumber3 .. " x " .. randomNumber4 .. " = "
	end
end



local function UpdateTime()

	-- decrement the number of seconds
	secondsLeft = secondsLeft - 1

	-- display the number of seconds left in the clock object
	clockText.text = secondsLeft .. ""

	-- handle the case when the timer runs out
	if (secondsLeft == 0 ) then

		-- reset the number of seconds left
		secondsLeft = totalSeconds
		lives = lives - 1

		-- once the timer runs out ask a new question
		AskQuestion()
	end
		-- *** IF THERE ARE NO LIVES LEFT, PLAY A LOSE SOUND, SHOW A YOU LOSE IMAGE
		-- AND CANCEL THE TIMER REMOVE THE THIRD HEART BY MAKING IT INVISIBLE
	if ( lives == 3 ) then
		heart1.isVisible = false
		
	elseif (lives == 2) then
		heart1.isVisible = false
		heart2.isVisible = false

	elseif (lives == 1 ) then
		heart1.isVisible = false
		heart2.isVisible = false
		heart3.isVisible = false

	elseif (lives == 0) then
		heart1.isVisible = false
		heart2.isVisible = false
		heart3.isVisible = false
		heart4.isVisible = false
			
		-- makes the clock invisible and  cancels the
		clockText.isVisible = false
		timer.cancel(countDownTimer)

		-- makes gameOver visible and other objects invisible
		gameOver.isVisible = true
		gameOverSoundChannel = audio.play(gameOverSound)
		questionObject.isVisible = false
		correctObject.isVisible = false
		incorrectObject.isVisible = false
		numericField.isVisible = false
		pointsObject.isVisible = false
	end
end

-- function that calls the timer
local function StartTimer()
	-- create a countdown timer that loops for infinity
	countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end

local function HideCorrect()
	-- change the correct object to be invisible
	correctObject.isVisible = false

	-- call the function that ask the question
	AskQuestion()
end

local function HideIncorrect()
	-- change the incorrect object to be invisible
	incorrectObject.isVisible = false

	-- call the function that ask the question
	AskQuestion()
end

local function NumericFieldListener( event )
	
	-- User begins editing "numericField"
	if ( event.phase == "began" ) then

		-- clear text field
		event.target.text = ""

	elseif (event.phase == "submitted") then

		-- when the answer is submitted (enter key is pressed) set user input to user's answer
		userAnswer = tonumber(event.target.text)

		-- if the user answer and the correct answer are the same:
		if (userAnswer == correctAnswer) then
			correctObject.isVisible = true


			-- when the user gets it correct add one point to the code and display it in text
			points = points + 1
			pointsObject.text = "Points : " .. points

			-- clear text field
			event.target.text = ""

			-- call the HideCorrect function after 2 seconds
			timer.performWithDelay(2000, HideCorrect)
		 
		 else

			incorrectObject.isVisible = true

			-- clear text field
			event.target.text = ""

			-- play a sound when the user gets it incorrct
			incorrectSoundChannel = audio.play(incorrectSound, {channel = 2})

			lives = lives - 1


			if (lives == 3) then
			 	heart1.isVisible = false

			elseif (lives == 2) then
			 	heart1.isVisible = false
			 	heart2.isVisible = false

			elseif (lives == 1) then
			 	heart1.isVisible = false
			 	heart2.isVisible = false
			 	heart3.isVisible = false

			elseif (lives == 0) then
			 	heart1.isVisible = false
			 	heart2.isVisible = false
			 	heart3.isVisible = false
			 	heart4.isVisible = false

			 -- makes the clock invisible and  cancels the
			 	clockText.isVisible = false
			 	timer.cancel(countDownTimer)

			 -- makes gameOver visible and other objects invisible 
			 	gameOver.isVisible = true
			 	gameOverSoundChannel = audio.play(gameOverSound)
			 	questionObject.isVisible = false
			 	correctObject.isVisible = false
			 	incorrectObject.isVisible = false
			 	numericField.isVisible = false
			 	pointsObject.isVisible = false

			end

		 	-- call the HideInCorrect function after 1 second
			timer.performWithDelay(1000, HideIncorrect)

		end

		-- reset the number of seconds left
		secondsLeft = totalSeconds + 1
	end
end


--------------------------------------------------------------------------------
--OBJECT CREATION
--------------------------------------------------------------------------------
-- create the lives to display on the screen
heart1 = display.newImageRect("Images/heart.png", 90, 90)
heart1.x = display.contentWidth * 7 / 8
heart1.y = display.contentHeight * 1 / 7

heart2 = display.newImageRect("Images/heart.png", 90, 90)
heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentHeight * 1 / 7

heart3 = display.newImageRect("Images/heart.png", 90, 90)
heart3.x = display.contentWidth * 5 / 8
heart3.y = display.contentHeight * 1 / 7

heart4 = display.newImageRect("Images/heart.png", 90, 90)
heart4.x = display.contentWidth * 4 / 8
heart4.y = display.contentHeight * 1 / 7

-- displays a question ands sets the colour 
questionObject = display.newText("", display.contentWidth/4, display.contentHeight/2, "Georgia", 80)
questionObject:setTextColor(255/255, 255/255, 255/255)
display.isVisible = true

-- create the correct text object and make it invisible 
correctObject = display.newText("Correct!", display.contentWidth/2, display.contentHeight*2/3, "Georgia", 80)
correctObject:setTextColor(0/255, 255/255, 0/255)
correctObject.isVisible = false

-- create the correct text object and make it invisible 
incorrectObject = display.newText("Incorrect.", display.contentWidth/2, display.contentHeight*2/3, "Georgia", 80)
incorrectObject:setTextColor(255/255, 0/255, 0/255)
incorrectObject.isVisible = false

-- displays numeber of points 
pointsObject = display.newText("Points = 0", 90, 60, "Georgia", 40)
pointsObject:setTextColor(255/255, 255/255, 255/255)
pointsObject.isVisible = true

-- create numeric field
numericField = native.newTextField(display.contentWidth/2, display.contentHeight/2, 170, 100)
numericField.inputType = "number"

-- add the event listener for the numeric field
numericField:addEventListener("userInput", NumericFieldListener)

clockText = display.newText(secondsLeft, 520, 600, native.systemFontBold, 150)
clockText: setFillColor( 255/255, 255/255, 255/255 )

-- create the game over screen
gameOver = display.newImageRect("Images/gameOver.png", 1000, 900)
gameOver.x = display.contentWidth /2 
gameOver.y = display.contentHeight /2
gameOver.isVisible = false

-------------------------------------------------------------------------------
--FUNCTION CALLS
-------------------------------------------------------------------------------

-- call the function to ask the question
AskQuestion()

-- call count down timer
StartTimer()