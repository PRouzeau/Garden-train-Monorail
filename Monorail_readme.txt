First documents issue: 26 november 2016
This is an Openscad simulation of a model of a garden train Monorail (scale ~1:22.5).
Only mechanical parts shall be 3D printed, the car bodies were bought "off the shelf"
Traditional modeling with plastic card board is done for the cabins, though it may be 
interesting to print some parts (window frames, hinges).
This is designed from scratch and use own OpenSCAD library (published on my GitHub account).

What is 3D printed ? 
- Bogies and wheels
- Car Hinges
- Way supports, rail supports, height adjustment sliders
- Way Switches mechanism (points)
- Current collection system and track supports

What may be printed (later): Battery support to use portable tools battery, as I always
have charged batteries available.

To see the simulation of the monorail, run the Monorail2.scad in OpenScad
The parameters of this simulation are defined within the file
To creates a part STL file, define a part Number in Monorail2.scad and run.
part=0 will show the complete model. 
You also can run the batch files (Windows only) to get all the STL files. 
Note that calculating the stl file will take some time, you may update your file manager
to check completion.
Wait the final execution of a batch file before starting the next one.
Note that the sub directories /STL and /STL_Way shall exist to have the batch file working.

Like the Schwebebahn monorail, cars are slighly off-centered to compensate the motor weight.

If you use a way built with pipe, you shall adjust diameter (see the general parameter) in 
the generator spreadsheet and regenerate the batch files. 
Default diameter (and maximum usable): 32mm (whatever is written in OpenScad file, batch 
parameters have priority).
Text/Spreadsheet Window batch generator file format is Libre office/Open office. 
This need to activate macros and may need to decrease security level to operate the macros.

Look the web presentation for details.

references:
https://github.com/Prouzeau/Garden-train-Monorail
http://rouzeau.net/twg/index.php?twg_album=3DPrint%2FLily  Lily photos Gallery

First public issues (no files) here :
http://forums.reprap.org/read.php?409,535426

Web presentation here:
http://rouzeau.net/GardenRailway/Monorail

Recent versions of OpenSCAD are needed, prefer the development snapshots:
http://www.openscad.org/downloads.html#snapshots

Credits:
People low poly STL files were kept from Sketchup 3D Warehouse:
- Businessman by JBJ design
- Covjek by Obi
- Woman with trousers modified from 'Medieval villagers' by Ze magic Vizard

The motor is a double axle motor from an old LGB Stainz.  More recent motors probably also fit.
The original casing is replaced by a printed casing. While disassembling the motor,
do not lost the shaft end balls.

The traction is not huge so a double axle is required so you cannot use a Playmobil motor.
A weight in the car under motor bogie may help traction (as on Garden train locomotives). 
Motor power is more than sufficient, that is the adherence which is limited. 
The rail is a 8mm diameter aluminium tube, which shall be supported at 300mm interval.
This is the largest possible interval as the aluminium rail tend to flex under load.
each tube end is supported at 50mm from the end and a shaft join tubes.
You need a roll bending system to make curves. A rail bender may be usable for that.

The current collection system is not extremely reliable and you may double it, as
any free wheel bogie can accept the current collection ensemble.
Current track is 'N' scale railway track. It shall be positioned with a printed template  
(see photos).

A battery system can be installed in the central car as the roof is removable. 
As realised, it is unpractical to set the battery in the motor car as the roof is not
 removable due to bogie support traversing the roof.
A nice improvement will be to build a roof in three parts or make a closable opening
in the roof on the motor car, to simplify the wiring.
However, it can be interesting to route wiring through cars for lighting.

While for me this was my first prints, I think it is preferable to have some experience
in 3D printing for such project. 

Wheels shall be well printed and shall run straight. (from the first protoypes,
wheels were modified to have a monobloc shaft support). Use calibrated diameter shaft (3mm).
Free wheel bearings are type 623 (10x3x4 - Dxdxt) 
O-ring in the motor wheel is imperative for traction. Paint the wheel BEFORE installing
 the o-ring.
 
If installed outside, you can now find ASA filament which resist naturally to UV (ASA is
the plastic used by LGB), however painting parts may have a more realistic look and will 
protect against UV. Remember that PLA may not cope very well with sun heat if you are in 
a sunny area. Also note that it can be difficult to glue on ASA.
See Thomas Sanladerer ASA test film: https://www.youtube.com/watch?v=0cGk7VK39ZQ
PETG is a good filament for all mechanical parts (most of this model parts...)

These was my beginning in 3D printing and I was willing to print as fast as possible, 
so the print quality is not very good. I made many paint layers to hide the print
faults. The real model looks better than the photos as flash underline the defaults.
Most parts are in PETG, except wheels in PLA to have sufficient quality.

Cars are NewQida (China) car bodies bought new on Ebay at Zenner shop (Germany).
If I had better searched on ebay, I could have bought identical complete cars for less
than what I payed the bodies. Search phrase on ebay.com:
"New G Scale Garden Passenger Coach Carriage Compatible 45MM" seller "1234-click"
or a complete set of 3 cars for 100£ (w/ shipping) on ebay Uk, seller "ecreastcoastrotor"
I glued low cost U plastic profiles under the base to simulate chassis and make a support
for the driver cabin. Driver cabin were built from scratch in plastic card.
Central car is a full body cut to 4 windows and the end is rebuilt with plastic card.
Roofs were not available, so they are also built with plastic card.
It may be less work to buy and modify a complete wagon. 
Using genuine LGB parts is delicate as it is very difficult to glue on the 
plastic used by LGB (ASA). It could be anyway of interest to use 90953 cars (ICE) to build 
a 'modern' looking Monorail if the early XX century style is not for your taste.



