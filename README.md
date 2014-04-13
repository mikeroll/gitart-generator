gitart-generator
================

Your contributions chart is all empty and dull? Use it as a canvas and draw something beautiful!

##How do I?##

1. Create a new repo on github.
2. Draw your image in the form of ascii art.
3. Let `gitart.sh` do the magic!

##Input file##

The magic needs some input. Define it in a text file:  
- Lines 1-7: Your Art. Any non-space character is considered a commit (be careful with tabs!).  
- Line 8: Your name.  
- Line 9: Your github login.  
- Line 10: Your email.  
- Line 11: Name of the repo to push to. You should create it repo before running the script.  
- Line 12: Starting date in %Y%m%d format. This will be the top left corner of your Art.  

Example input file is provided.

##Warnings##

- This script messes with your system time and therefore requires root privileges. Use at your own risk.
- An ugly timezone hack: time is set to 12:00 AM when shifting dates.
- Tested on Linux only.
