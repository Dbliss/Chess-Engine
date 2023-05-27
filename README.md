# Chess-Engine
Chess Engine made in Matlab

Run the code using "playGame.m"

To change who you want to play as (or the computer) then change 'playersColour' to 1 or 2, being white and black.

To change the difficulty of the bot,  edit lines 41 and 83. They look likes this

  while toc(startTime) < 4 || depth < 5

Play around with the number, but increasing the minimun depth will ensure the bot plays to atleast a specific depth, while increaing the time will allow the bot more time to make a move.
General rule of thumb is a startTime < 4 can expect and average move time of 4x8 = 32 seconds. So setting a minmiun startTime of 8 would mean 8x8 = 64 seconds average move time.
