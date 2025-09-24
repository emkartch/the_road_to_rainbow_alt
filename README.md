This is my game for the "Loop Implementation" assignment in ATLS 4140.

9/14 - I started by downloading the base of the [finite_state_machine](https://github.com/godotengine/godot-demo-projects/tree/master/2d/finite_state_machine) from the [Godot Demo Projects Repo](https://github.com/godotengine/godot-demo-projects/tree/master) (which included using their provided assets). It took me about 30 minutes to set this up.

9/14 - Created own mob sprite by editing the player one – 30 minutes

9/14 – Added mobs that will follow and attack the player – 60 minutes – Followed tutorial:  
https://www.youtube.com/watch?v=GwCiGixlqiU

9/14 – Player able to attack mobs – 90 minutes – Followed tutorial:  
https://www.youtube.com/watch?v=GwCiGixlqiU

9/14 - The correct amount of mobs spawn and they don't get stuck out of bounds – 90 minutes

9/14 - Mobs able to attack player – 45 minutes

9/14 - HUD set-up – 30 minutes

9/15 – Knockback mobs when they are hit – 120 minutes – Referenced:
https://www.reddit.com/r/godot/comments/1b0vy14/how_to_add_knockback_to_a_player_when_getting_hit/

9/15 – Create instance of "boss mobs" that appear once you defeat a wave of "normal mobs" – 60 minutes

9/15 - Created three levels to progress through with the mobs getting harder and harder each time – 30 minutes

9/15 – Fix health bar errors – 30 minutes

**Core Loop**: Defeat enemy wave – Defeat boss – Go to next level

**First Secondary Loop**: Loose Health – Defeat Boss – Gain some health back

**Second Secondary Loop**: *N/A*

**Third Secondary Loop**:  *N/A*

**Hard Gate**: Defeat Boss

**Soft Gate**: *N/A*

**Faucet**: Gain health back after defeating boss

**Sink**: Lose health to enemies

**Important Note**: Since I have spent over 10 hours on the project already, it was told to me that only implementing my main idea for a core loop and submitting that (with its hard gate and other mini loops included) would be fine for full points.

**Important Note**: As of 9/16, the name "The Road to Rainbow" won't currently make sense for the gameplay, but will make sense after more polish.

9/17-9/19 – Worked with instructor to fix stagger animation overlap issues – 45 minutes

--------------------------------------------------------------------------------------

This is my update to my game for the "Adding Juice" assignment in ATLS 4140.

9/20 - Update game to be 7 levels instead of 3 in order to fit the theme – 45 minutes

9/20 – Simplify multiple functions into one working function – 30 minutes

9/21 - Find suitable sprites for the game, resize them, recolor them, and import them - 90 minutes

9/21 - Change the Player animations and state machine to correspond with an AnimatedSprite2D node instead of an animation player - 60 minutes

9/21 - Get Player animations to play in the correct directions at the right times - 60 minutes

*New Bug Introduced*: Player stagger animation will continue playing after starting if player doesn't give the program any more input.

9/23 - Add Mob animations - 45 minutes

9/23 - Draw and add rainbow hud display to game that corresponds with level progression - 45 minutes

**Important Note**: As of 9/23, I didn't have time to focus on the audio or fixing the small bugs within the six hour block of time.

Assets from:  

- Godot Demo Projects Repo - https://github.com/godotengine/godot-demo-projects/tree/master  
- Hana Caraka (Base Character) by Otterisk - https://otterisk.itch.io/hana-caraka-base-character#google_vignette  
- Slime Animation Pack by Virusystem - https://virusystem.itch.io/slime-pack-anmations  

