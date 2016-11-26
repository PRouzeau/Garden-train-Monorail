// Monorail 26 nov. 2016
include <Z_library.scad>
// Copyright P.Rouzeau 2015-2016  - license : OHL V1.2
// This license does apply for any derived work whatever scale is used, including full scale ! This apply especially to the on-vehicle switch system.
// Vertical reference is rail axis
/* [Global] */
//Part
part=0; // [0:Whole model, 1:Freewhel h1, 2:Freewhel h2, 3:Motor wheel h1, 4: Motor wheel h2, 5:Free bogie h1, 6:Free bogie h2, 7:Free bogie arm h1, 8:Free bogie arm h2, 10:Motor bogie h1, 11:Motor bogie h2, 12:Motor bogie arm h1, 13:Motor bogie arm h2,  14:Centering ring, 21:Car spreader, 22:Top hinge cup, 23:Top hinge shaft, 24:Bottom hinge cup, 25:Bottom hinge cup support, 26:Bottom hinge shaft, 27:Bottom hinge shaft slider, 28:Hinges drilling template, 31:Name plate, 37:Current collection frame, 38:Current collection pads, 39:Current track position template, 41:Rail support for rectangular beam, 43:Rail support for circular beam, 44:Current track support for circular beam, 46:Way side support for rectangular beam, 47:Way side support for circular beam, 48:Way side support 2, 49:Way side support 3, 51:Rect beam support - side attach, 52:Rect beam support - top attach, 53:circular beam support - side attach, 54:Circ beam support - top attach, 55:Circ beam support - top attach - top beam part, 56:Way end stop, 57:Switch hinge h1, 58:Switch hinge h2, 59:Adjustable height switch roller bearing, 61:Set - 2 free bogie wheels, 62:Set - 2 motor bogie wheels, 64:Set - Simple bogie - bearing boxes,   66:Set - Motor bogie - side arms]

//Parts quantity
partqty=0; // if different of 0, change default part qty
/* [General] */
//Banking angle
angbank=0; // [-16:16]
//car banking angle +/- 16° maximum - play with it !

/*[Car]*/
//Car width
car_wd = 112; // LGB : 112
//Car height
car_ht = 92;
//Roof arch height
roof_ht = 19; // roof height included roof thickness
//End cars length
car_len = 445; 
//LGB simple car: 192 : long cars : 445 ?
//End car windows qty
car_windows = 7;
//Central car length
car_len2 = 200; 
//Central car windows qty
car_windows2 = 3;
//Car door side offset
door_offset = -10; 
//Car position data
bgdec = 100; // start point
//Bogie axis offset/car end
bgoffset = 50;
//Space between two cars 
carspace = 40; // dictate minimum radius: for 34, ~750 (diam 1500), for 40, ~600 -> length 1m for 90° bend 
// this take into account roof extra-length of 3mm, so real space for 34 is 28.

/*[Bogie]*/
//Wheel diameter (on rail axis)
wheeldia = 40; // diameter to rail centre
//Motor wheel groove size
wheelgroove = 2;
//Free bogie Wheel distance
wheel_space = 76;
//Bogie beam height (bearing box)
barht = 14; // (enclosing wheeel bearings)
//Articulation bearing position / rail axis
BB_vpos = -69; 
//define way clearance

//Car side offset (from rail axis)
car_hpos  = 2;
//distance between bogie axis and support face
distpylon = 70; 
// (not main pylon face)

/*[Way]*/
//Circular way beam
pipe_way = false; 
//way is circular: false-> rectangular beam -> set beam_width for proper current pad collection -> way_offset =6
//Distance beam top to rail axis
railbeamdist = 9; //distance between rail axis and top of the rectangular beam 
//Rectangular way beam width maxi
beam_width = 27; //maxi ~20- if modified, modify offset to maintain power pad place for 27, way_offset = 2.5
// for power rail installation, the beam shall not protrude more than 11 mm on the rail side: adjust horizontal offset accordingly. modifiy 'angbank' value to see results.
//Rectangular way beam height
hbeam  = 27; // max ~27 
//Way beam diameter if circular
diam_way = 32; // [25:32] pipe diam 32 or 25

//Way support board width
wtopbeam = 27; 

//ppw_vpos = (diam_way==32)?-22:(diam_way==25)?-19:0;
ppw_vpos = -diam_way/2-6.5;
//ppw_vpos = -22; //pipe_way tube avis pos -22 for pipe_way 32, -19 for pipe_way diam 25 ??? more linear stuff ?

//Beams support board distance (from way beam top) 
beamsupspace  = 54;
  // side support beam face to beam face : distance 54 mm
//Bolted beams support board distance (from way beam top) 
beamsupspace2 = 69; 
  // beam support bolted below : face to face distance ~ 69mm 

/*[Power]*/
//Brush axis position below rail 
brushAxis = -22;//~ -22:vertical pos of brush pad axis. shall be relatively low (to align as far as possible the brush pad axis, the rail and the power beam articulation axis: this minimize vertical excursion): 0: no rail
brushAxisHt = -18;// horizontal pos of brush pads

/*[Colors]*/
//Cabin color
//Car color 
car_color = "red"; // ["red", "lightblue", "blue", "green", "yellow", "orange"]
//Roof color
roof_color = "grey"; // ["grey", "black", "brown"]
//Window frame color
winframe_color = "beige"; // ["beige", "grey", "black"]
//Car structure color
car_struct_color = "darkgrey"; // ["darkgrey", "black"]

/*[Hidden]*/
clr_glass = [0.5,0.5,0.5,0.8]; // glass color
//$ssw = true; // future on-vehicle switching - add gussets
// Postponed to undefined date
cabin_color = car_color; 
sswaxis = wheeldia/2+barht/2+4.5; // = 31.5
// misc. parameters
diamNut3 = 6; // check ??
diamNut4 = 8.1; // check ??
thkNut4  = 3.2;

plb=0; // play for bearing holes positive : hole larger
holeplay=0.20;

// LGB 2010 stainz "1" motor dimensions, as measured 
// This is a quite old motor, new may differ- Stainz "2", more common, looks quite the same as Stainz "1"
// shaft dia: 6mm 
// flat distance : 4.06
// flat length : 2.5 mm
// shaft length : 50.55
// shaft space : 76.4 mm
// motor diameter : 29.85 mm
// motor length : 50.85 mm
// motor centering ring : 11.9 mm, extension 2.1 mm
// non symetrical: shaft extension shorter on connection side : 19mm, other side 20mm
// so shift the motor by 0.5 mm on connection side (same as anti rotation pin)
// anti-rotation pin dia 1.93 at 9mm radius
// motor shaft length: 90.82 mm
// motor shaft dia : 2.45 mm
// motor pinion dia (ext ) : 5.65
// pinion teeth step : 1.61 mm : module 0.5
// shaft end balls : 2.95 mm
// gear wheel : 34 teeth, diam ext = 18.1 mm  thickness : 6.02 mm
// gear plastic extension total width (symetrical) = 20, dia = 8.9 mm
// axis space : approx 10.8mm - plausible - DP : (17mm + 4.65)/2 -> 10.825 mm
// electrical connection : lg 7.5, x 2.7 mm

// Note that playmobil bogies does only have one driving axle and this is not sufficient for good traction

// motor block data 
mtshaftdist = 10.85; // distance between motor axis and wheel axis 
// it is ~equal to gear teeth nb * 0.25 + 2.35
mtblwheel_space = 76.4;
gearwd  = 6; // gear width
gearext = 20; // plastic gear extension
gearteeth = 34; // teeth number - module is 0.5
geardia = gearteeth*0.5+1;
motor_len = 51; // motor length

dispswitch=true; // display the switch system

//Car position
car_vpos = BB_vpos-98; // vertical position (floor) relative to the rail axis 

way_hoffset=(pipe_way)?diam_way/2-9:beam_width/2-10; 

disp(); // display part or complete system, depending part selector
if ($ssw)
  self_switch(0); //display on-vehicle switching-system too complex

module disp() {
  $pad=true;
  //-- wheels -----------------------------
  if      (part==1) wheel();          // simple bogie free wheel
  else if (part==2) wheel(0,true);    // simple bogie free wheel  
  else if (part==3) wheel(wheelgroove);// motor wheel with groove for rubber o-ring
  else if (part==4) wheel(wheelgroove, true);// motor wheel with groove for rubber o-ring
  //-- simple bogie -----------------------  
  else if (part==5) rot(180) sbogie_h1();  // simple bogie part 1 (pylon side)
  else if (part==6) rot(180) sbogie_h2();  // simple bogie part 2
  else if (part==7) rot(180) side_arm();    // vertical suspension beam, simple bogie 
  else if (part==8) dmirrorz(false) side_arm();    // vertical suspension beam, simple bogie   
  //-- motor bogie ------------------------ 
  else if (part==10) mirrorx() rot(90) motor_bogie();     // motor bogie part 1 (pylon side)
  else if (part==11) rot(90) motor_bogie(true); // motor bogie
  else if (part==12) rot(180) side_arm(true);// vertical suspension beam, motor bogie  
  else if (part==13) dmirrorz(false) side_arm(true);// vertical suspension beam, motor bogie
  //-- bogie accessory --------------------- 
  else if (part==14) duply (14,qty(4)) duplx (14,1) BBcentring();           // bogie bearing centering ring (4 per bogie)
    
 //-- car accessories ----------------------
  else if (part==21) duplx (11,qty(2)) rot(0,90) car_spreader();  // car spreader for suspension rod centering 
  //-- car articulations --------------------  
  else if (part==22) rot (0,180) ball_cup(); // center car top articulation
  else if (part==23) ball_arti(); // center car top articulation - end car side
  else if (part==24) rot (0,180) ball_cup_floor(); // center car floor articulation
  else if (part==25) rot (0,0) ball_cup_floor2(); // center car floor articulation
  else if (part==26) ball_arti_floor(); // center car floor articulation - end car side
  else if (part==27) rot (180) slide_arti_floor();//slider for floor center car articulation
  else if (part==28) rot (0,-90) arti_template(); //drilling template
    
  //-- miscellaneous car accessories ------------   
  else if (part==31) plate(["PRZ Industries"],undef, 34,10,1.5); // manufacturer plate   
  //-- current collecting system -----------
  else if (part==37) rot(127.2)  barbrush();  // beam supporting current collecting pads
  else if (part==38) duply (11) brushpad(); //current collecting pad- size from way beam width
  else if (part==39) tsl (0,0,-2.5) rot(90) track_template();  
  
// Way parts   (>40)
  //-- rail support ------------------------
  else if (part==41) tsl (0,0,9/2) duplx(10,qty(4)) rot(0,90) rail_support();         // Rail support
  else if (part==42) duplx(10,qty(2)) rot(0,90) rail_support(true);         // Rail support  - dual width  - no longer used
    
  else if (part==43) duplx(10,qty(2)) rot(0,90) rail_support(false, true);         // Rail support for pipe
  // track support for circular way only (here diam 32) -----   
  else if (part==44) duplx(7,qty(8)) rot (90,-90) track_supp(); 
  //-- miscellaneous way supports ------------
  //-- way side support ----------------------
  else if (part==46) tsl (0,0,12.8/2) rot(0,90) way_side_support1(12.8); // side way support, beam side
  else if (part==47) tsl (0,0,12.8/2) rot(0,90) way_side_support1(12.8, 32); // side way support, beam side, for tube diam 32
    
  else if (part==48) tsl (0,0,-10.2) rot(0,180) way_side_support2(); // side way support
  else if (part==49) tsl (0,-distpylon, -2) 
    rot (180) rotz (180) way_side_support3(); // side way support pylon side
  //-- way supports from top ------------------
  else if (part==51) tsl (0,0,12.8/2) rot (0,90) barsep(false,12.8);    // beam support, side attach
  else if (part==52) tslz (12.8/2)  rot (0,90) barsep(true, 12.8);// beam support, top attach 
  else if (part==53) tslz (12.8/2) rot (0,90) barsep(false,12.8,true);    // beam support, side attach
  else if (part==54) tslz (12.8/2) rot (0,90) barsep(true, 12.8,true);// beam support, top attach   
  else if (part==55) tslz (60.60) rot (0,180) barsep2();  // beam support, top attach, top beam part  
    
  //-- way end stop (rectangular beam only) ----------
  else if (part==56) tsl (0,0,3) rot (90) way_stop();
  //-- switch  (point) ------------------------
  else if (part==57) tslz (5) rot (90) switch_hinge1(); // half of switch articulation
  else if (part==58) tslz (5) rot (90) switch_hinge2(); // other half of switch articulation
  else if (part==59) tslz (6)rot(90) BB_switch();    // adjustable height switch roller bearing

// grouped parts    
  else if (part==61) {
    duplx (48, qty(2)) wheel();            //2 free bogie wheels
    tsl (0,48)
      duplx (48, qty(2)) wheel(0,true); 
  } 
  else if (part==62) {
    duplx (48, qty(2)) wheel(wheelgroove);  //2 motor bogie wheels
    tsl (0,48)
      duplx (48, qty(2)) wheel(wheelgroove,true); 
  }
  else if (part==64) { // simple bogie, bearing boxes
    tsl (0,0,7) rot (180) sbogie_h1(); 
    tsl(0,4, 7) rot (180) sbogie_h2(); 
    tsl (-3,-18,12) rot(180,0,210) side_arm();
    rotz (-10) tsl (8,-1, 12) dmirrorz(false) side_arm(); 
  }
  else if (part==66) { // motor bogie - side arms
    rot(180) side_arm(true);
    rotz (-90) tsl (52,-20, 10) dmirrorz(false) side_arm(true); 
  }
  else if (part==67) { // car articulations 1 set (2 needed)
    tsl (0,0,13) rot (0,180) ball_cup(); //center car top articulation
    tsl (-25,0,6) ball_arti(); //center car top articulation - end car side
    tsl (0,16,15) rot (0,180) ball_cup_floor(); //center car floor articulation
    tsl (-41,39) rot (0,0) ball_cup_floor2(); //center car floor articulation
    tsl (0,27) ball_arti_floor(); //center car floor articulation - end car side
    tsl (-2,49) rot (180) slide_arti_floor();//slider for floor center car articulation
    tsl (-8,62) rot (0,-90,90) arti_template(); //drilling template
  }
  else if (part==68) { // current collector set
    *cubez (100,100,-1.1, 0,0,0); // ref plane
    tsl (0,0,12.26) rot(127.2)  barbrush();  //to adjust if parameters modified
    tsl (0,14,9)
      duply(11) brushpad(); 
  }
  else if (part==70) duply(26) duplx(10,3) rot(0,90)rail_support();// 8 simple rail supports
  else if (part==71) { // side way support
    tsl (-10,-35,-7)
      rot(0,180) way_side_support1(); // side way support, beam side
    tsl (10,35,-9-holeplay) 
      rot(0,180, 180) way_side_support2(); // side way support
    tsl (-12,-91, -1) 
      rot (180) rotz (180) way_side_support3(); 
  }  
  else if (part==99) {} // just blank screen
  else  {
    $pad=false; 
    way(); // display way
    disptrain(); 
  }    
}
// tel 9 441 908 959 fictive tel obtained with letter from word 'industries' letter order - not allocated in most countries (too long).

//cubez (100,100,1, 0,0,-13.4);

function qty(nb) = (partqty)?partqty-1:nb-1;

module disptrain() {
  poscar1 = bgdec;
  poscar2 = bgdec+car_len+carspace;
  poscar3 = bgdec+car_len+car_len2+2*carspace;

  rot (angbank) {  
   // bogies 
    tsl (bgdec+bgoffset)            bogie();
    tsl (bgdec-bgoffset+car_len)    bogie();
    tsl (poscar3+bgoffset)          motor_block(); 
    tsl (poscar3-bgoffset+car_len)  bogie(true);
    tsl (0,car_hpos, car_vpos) {
      color ("grey") { // people
        tsl (poscar3+car_len+25,-25,2)
          rotz (90)
          scale (0.04444)
            import ("Businessman.stl");  
         tsl (poscar3+car_len+30,25,2)
          rotz (90)
          scale (0.04444)
            import ("Covjek.stl");  
         tsl (50,0,2)
          rotz (-90)
          scale (0.04444)
            import ("Woman_trousers.stl");  
      }
    // car links 
      tsl (car_len2/2+poscar2)
        dmirrorx ()    
          tsl (-carspace/2-car_len2/2) {
            tsl (0,door_offset) bellow();
            color ("yellow") {
              tsl (0,0,car_ht+4) {
                ball_cup();
                ball_arti();
              }  
              // floor articulation
              dmirrorz(false) ball_cup_floor();
              dmirrorz(false) ball_cup_floor2();
              dmirrorz(false) ball_arti_floor();
              slide_arti_floor();
            }  
        }  
      // cars  and platforms
      tsl (poscar1) {
        dmirrorx(false) platform(true);
        platform_plates(45,true); 
        car(car_len,car_windows, car_color);
      }  
      tsl (poscar2) 
        car(car_len2,car_windows2, car_color);
      tsl (poscar3)
        car(car_len,car_windows, car_color);
      tsl (poscar3+car_len) {
        platform();
        platform_plates(45,false); 
      } 
      //QR code of monorail web site displayed on side
      tsl (poscar3+car_len-65,-car_wd/2-1,21) { 
        color ("black") 
          rot (90,0,0)  scale([0.2,0.2,0.007])
            surface(file ="qrcode_monorail.png",center = true, convexity = 5, invert = true);  
        color ("white")      
          cubey (40,-0.5,40, 0,1);     
      }
    } 
  }
}

module way_beam(wlen=1000) {
  module Ntrack() { // electrical rail (model train track 'N' gauge)
    color("gold")
      dmirrorz()
        cubex (wlen+sign (wlen)*11,2.15,1.5, -sign(wlen)*5.5,-1.1-1.075,4.5+0.28);
    color("brown")
      cubex (wlen+sign (wlen)*11,1.1,16.5,   -sign(wlen)*5.5,-0.55); 
  }
  color("silver")  //track 
    cylx (8,wlen+sign(wlen)*5.5,  -sign(wlen)*5.5);
  if (brushAxis) 
    tsl (0,brushAxisHt+8,brushAxis-1)  Ntrack();
  if (pipe_way) {
    color ("grey") difference() {
      cylx (diam_way,wlen, 0,way_hoffset,ppw_vpos, 50);
      cylx (diam_way-6,wlen+sign(wlen)*100, -sign(wlen)*50,way_hoffset,ppw_vpos, 50);
    } 
    if (brushAxis) 
      duplx (-100, floor(wlen/100)) track_supp(); //current track support  
  }
  else 
    color ("burlywood")  
      cubex (wlen,beam_width,hbeam, 0,way_hoffset,-railbeamdist-hbeam/2); 
}

module track_supp(circ_way=true) { //track support for circular way only
  if (circ_way) 
    difference() {
      u() {
        tsl (0,brushAxisHt+8,brushAxis-1) { 
          cubex (7,5,18,  0,2,0.5); 
          cubex (2.7,4,7.5,  0,-0.5);
          difference() {
            cylz (-3,4,  1.6,-2);
            tsl (1.6,-5, -2.5)
              cubez (6,5,5);
          }  
        }
        tsl (0,diam_way/2-9, ppw_vpos)
          rot (-36)
            cubey (7,-3.2,8,  3.5,-diam_way/2+1); 
      }
      cylx (diam_way,20, -1,diam_way/2-9,ppw_vpos, 100);
      tsl (3.5, diam_way/2-9, ppw_vpos)
        rot(-36)
          cone3y (6,3, -5,-1.7,5, 0,-diam_way/2-0.3);
    }
}

module track_template() { // position the track from the pads
  difference() {
    cubey (94,1,25, 0,2.5,0); 
    dmirrorx() cubey (29,10,18.4, 29,0,0); 
  }
  color("green")
  dmirrorz () {
    cubey(29,2.5,2,  0,3,5.4+1);  
    cubey(29,0.8,2,  0,3,4+1);  
  }  
}

module way() {
  module pylon() {
    color ("burlywood") {
      cubez (17,23,-405, 0,101,7);
      cubez (32,19,-60, 0,101-21.2,7);
    }  
   * color ("silver") { // support with simple rod
      cyly (6,110, 0,0,-18);  
      cyly (12,5, 0,8.5,-18,6);
      duply (46) 
        cyly (12,5, 0,55.5,-18,6);
    }
    way_side_support();
  } // end pylon()
  way_beam (2100);
  
  duplx (1000,2) tsl (25) pylon(); // pylons
  color ("green")
    duplx (1000)
    duplx (333.3,1,365) rail_support(false, pipe_way); // rail supports
  *tsl (150, -75) barsep(); // to show space needed
  ditrellis = (diam_way==32) ?20:16; 
  
  if (pipe_way) 
    color ("gray") tsl (650) {
      tsl (0,96, 150+ppw_vpos)
        cylx (diam_way, 1350);
      tsl (0,10,ppw_vpos)
        duplx (300,3,100)
          rot (-30) {
            cylz (ditrellis, 170);
            rot (0,61)
              cylz (ditrellis, 350);
          }  
     }  
// switch   
  if (dispswitch) {
    space_switch = 55;
    lg_switch = 550; // switching beam length
    ang_switch = -7.5;   
    lg_cont = 1850; // Beam continuing straight after switch
    //(from articulation axis)
    color ("burlywood")  
      tsl (-2400) 
        cubez (lg_cont-lg_switch,27,120,  (lg_cont-lg_switch)/2-50,0,-railbeamdist+beamsupspace2);
    tsl (-6) 
      rotz (ang_switch) 
        tsl (-1670) {
          pylon(); 
          tsl (0,car_hpos, car_vpos)
            car(445,7, car_color);  
        }
    color ("red") {    
      switch_hinge1();    
      switch_hinge2();    
    }  
    
    tsl (-lg_switch-27)
      color ("burlywood")    
      rotz (ang_switch/2){ // gantry 1
        cubez (beam_width,hbeam,-450, 0,-90,50);
        cubez (beam_width,hbeam,-450, 0,90+space_switch,50);
        cubez (beam_width,265,hbeam,  0,28,beamsupspace-railbeamdist);
        // gantry 2
        cubez (beam_width,hbeam,-450, -600,-125,50);
        cubez (beam_width,hbeam,-450, -600,192,50);
        cubez (beam_width,345,hbeam,  -600,33,beamsupspace-railbeamdist);
      }  
    tsl (-lg_switch-16)   // straight continuation
      way_beam (-lg_cont);  
    tsl (-8) // switch continuation
      rotz (ang_switch)
        tsl (-lg_switch-8)
          way_beam (-lg_cont);  
      
    tsl (-9)  color("green")  {
      duplx(-600, 3, -32 -lg_switch) barsep(true); 
      duplx(-600,1,-1200-32-lg_switch ) barsep2(); // suspended from top beam     
      rotz (ang_switch) 
        duplx(-600, 1, -32 -lg_switch) barsep(true); 
    }
    tsl (-6) {
      color ("burlywood") 
        cubez (120,wtopbeam,hbeam,60-6-lg_switch,0,beamsupspace-railbeamdist);
      tsl (-8)
        way_beam (-lg_switch);
        //cubez (lg_switch,beam_width,-hbeam,-lg_switch/2-6,0,-railbeamdist);
      
      duplx (80)  color("green")
        tsl (15 -lg_switch)
          barsep(); 
      tsl (-lg_switch-8,0,beamsupspace-railbeamdist+hbeam) {
        color ("red")
          BB_switch();
        color ("silver") {
          cylx (16,5, -16,0,8);
          cylx (-5,28, -5,0,8);
          cylz (-4,40, 12,0,-2);
        }  
      }  
    } 
  } // end of switch
    // continuing with suspended way - there is no vertical adjustment
}

module way_stop(pos=0){
  tsl (pos) 
    difference() {
      union() {
        hull() {
          cubez (55, 1.5, 5,   5+55/2,-2.25,-railbeamdist);
          cubez (15, 1.5, 5,   5+15/2,-2.25,35);
        } 
        hull() {
          cubez (50, 12, 3,  5+50/2,3,-railbeamdist);
          cubez (60, 6,  3,  60/2,0,-railbeamdist);
        }  
        hull() {
          cubez (2, 12, 5,   6,3,-railbeamdist);
          cubez (2, 4, 5,    6,-1,35);
        }  
        cubez (20, 6, 3,    20/2,0,35+2);
        intersection() {
          cubez (6,6,railbeamdist+40, -0.50,0,-railbeamdist);
          cylz  (8,80,  3.5,0,-railbeamdist-3);
        }
      }  
      duplx (11)
        cone3z (4,8, 5,2.1,-5,  12,2.7,-railbeamdist+1);
      cone3z (4,8, 5,2.1,-5,  50,2.7,-railbeamdist+1);
    }
}

*color("red")
  way_stop(1275);

module motor_block() {
  module motor() {
    cylx (-30,45);
    cylx (-2.5, 91);
    dmirrorx() 
       cylx(5.7,12,  31);
  }
  tsl (0,0,car_ht+car_vpos+0.1) car_spreader();   // car horizontal beam for support rod
  dmirrorx() 
    tsl (mtblwheel_space/2,0,wheeldia/2) 
      rot (-90) {
        wheel(wheelgroove);
        mirrorz() wheel(wheelgroove, true);
      }  
  car_bogie();
  tsl (0,-23.5,wheeldia/2) {
    color ("silver") {
      tsl(0,0,-mtshaftdist) motor();
      dmirrorx() {
        cyly(-6,50.6,  mtblwheel_space/2); 
        cyly(-18,6,    mtblwheel_space/2); 
      }
    }
    color("yellow"){ 
      motor_bogie(false);
      mirrory()
        motor_bogie(true);
    }  
  }
  tsl (0,0,wheeldia/2) color ("grey") { 
    dmirrorx()
      rot(0,-90) side_arm(true);
  } 
}

module motor_bogie(supp=false) { // half motor block 
  lg2 = wheel_space-wheeldia-4; // for self-switch gusset
  difference() {
    union() {
      cylx (-34.5,62,0,0,-mtshaftdist,60);
      dmirrorx() {
        hull() {
        cyly (-geardia-4,10,mtblwheel_space/2,0,0,50);
        cyly (-8,10,   mtblwheel_space/2-12,0,8.5,50);
        cyly (-12,10,  mtblwheel_space/2-18,0,1,50);  
        cyly (-10,10,  mtblwheel_space/2+7,0,-mtshaftdist+0.5,50);
        cyly (-22,10,  mtblwheel_space/2-6.5,0,-mtshaftdist-5.3,50);
        } 
        hull() {
          cyly (geardia+4,5, mtblwheel_space/2,0,0,50);
          cyly (12,17,       mtblwheel_space/2,0,0,50);
          cyly (9,17,        mtblwheel_space/2-8,0,-mtshaftdist,50);
        }
        hull() { // bottom assembly gusset
          cubey (68,6,1,  0,-3,-mtshaftdist-15); 
          cyly (-7, 6,   20, 0,-mtshaftdist-17-3);
          cubey (20,6,7,  0,-3,-mtshaftdist-17-3); 
        }
        if (supp)   
          hull() { // side gussets for attach
            cubey (4,16,8, 12.25+2, 0,-19);
            cylx  (14,4,   12.25, 6.5,-51, 32);
            cubey (4,2,1,  12.25+2, 0,-55);
          } 
        else if ($ssw)
           tsl (0,23.5)
             hull() { // self-switch gusset
               cylx (9,-3,    lg2/2,0,barht/2+4.5);
               cubez(3,12,28,  lg2/2-1.5,-18,-22);
             }  
      }
    } // then whats removed 
    if (supp) {  // attach holes
      cylx (-4,99, 0,9,  -32);
      cylx (-4,99, 0,6.5,-51);
    }
    else 
      cylx (-4,66,   0,23.5,barht/2+4.5); 
    cylx (-30.5,motor_len, 0.5,0,-mtshaftdist,50); // motor space
    cylx (-12.4,motor_len+5, 0.5,0,-mtshaftdist,50); // motor centering rings
    cylx (2.5,4,      motor_len/2-1,0,-mtshaftdist-9,50); // anti-rotation
    cylx (-7,88,    0,0,-mtshaftdist); // pinion opening
    cylx (-3,95.5,    0,0,-mtshaftdist); // motor shaft room
    cubey(16,15.2,    3.5,motor_len/2+0.5,0,-mtshaftdist); // room for connection
    cylx (4.5,20,     motor_len/2, 13,-mtshaftdist); //cable passage
    gearsp = gearwd+1.2;
    dmirrorx() {
      tsl (45.2+2.5,0,-mtshaftdist)
        rot (0,90) cylinder (d1=3, d2=0, h=1); //motor end ball cup
      cyly (-geardia-0.8,gearsp,  mtblwheel_space/2,0,0,50); // gear space
      cyly (-6.05,66,          mtblwheel_space/2,0,0,  50); // shaft hole
      tsl (mtblwheel_space/2, gearsp/2-0.1)
        rot (-90) cylinder (d2=9.5, d1=geardia+1, h=gearext/2+0.4-gearsp/2+0.1, $fn=40); // room for gear plastic extensions
      //cyly (-9.5,gearext+0.5,  mtblwheel_space/2,0,0,  50); // room for gear plastic extensions
      cyly (-3,66,             mtblwheel_space/2-12,0,8.5,  50); // fixation hole
      cyly (-3,66,             mtblwheel_space/2-3,0,-mtshaftdist-11,  50); // fixation hole
      cyly (-2,66,             mtblwheel_space/2-6,0,-mtshaftdist-8.5, 50); // centering hole
      cyly (-3,66,             20,0,-mtshaftdist-17-3); // bottom gusset assembly holes
      tsl (0,0,-mtshaftdist) {
        duplx (-13)
          rot (21)  cylz (-6,66,  21.7); // ventilation holes
        duplx (-14)
          rot (48) cylz (-6,66,  19.5);
      }  
    }  
    tsl (0,-20,-22)
      cube ([150,40,80], center=true); // cut half of the box
    tsl (0,20+17,-22)
      cube ([150,40,80], center=true); // cut 
    
  }
}

module bogie (current=false) { // non motorised bogie
  dmirrorx() 
    tsl (wheel_space/2,0,wheeldia/2) {
      rot (90) {
        wheel();
        mirrorz() wheel(0, true);
      }  
      color ("grey") {
        cyly (-3,21);
        dmirrory() 
          cyly(10,4,0,6);
      }  
    }
  tsl (0,0,wheeldia/2)  { 
    color("yellow") {
      sbogie_h1();  
      sbogie_h2();
    }  
    color("grey")
      dmirrorx()
        rot(0,-90) side_arm();
  }
  car_bogie();
  baseang = 2;
  
  color ("silver") {    
    tsl (0,-18,wheeldia/2) {
      cylx (-4,40, 2); 
      dmirrorx() cylx (diamNut4,3.2, 15.6,0,0, 6);   
    }  
    tsl (0,-23,-17 +wheeldia/2) {  
      cylx (-4,40, 2); 
      dmirrorx() cylx (diamNut4,3.2, 15.6,0,0, 6);   
    }  
  }
  if (current&&brushAxis) { // current collection system
    tsl (0,5,6)
      rot(-angbank*0.82+baseang) 
        tsl (0,-5,-6) {
          color("orange") barbrush();  
          dmirrorx() 
            tsl (30,brushAxisHt,brushAxis) 
              rot(-angbank*0.18-baseang) color ("green") brushpad();
         * tsl (0,brushAxisHt,brushAxis) 
             rot(-angbank*0.18-baseang)  track_template(); //???
        }  
    color ("silver") {    
      cylx (-4,66, 0,-18,wheeldia/2); // attach holes
      cylx (-4,46, 0,-23,-17 +wheeldia/2);   
      dmirrorx() { // spring
        cylx (diamNut4,3.2, 15.6+8+3.5,-18,wheeldia/2, 6);   
        difference () {
           cylx (7,8, 19,-18,wheeldia/2);
           cylx (5.5,10, 16,-18,wheeldia/2);
        }
        tsl (26 ,-14.8,20)
          rot (-13-angbank/2,-4) cylz (0.8,-50);
        tsl (19.5,-21.2,20)
          rot (2.5)              cylz (0.8,-22);  
      }  
    }  
  }     
}

module car_bogie() {
  color ("silver")  // axis and bearing
    cylz (4,-135, 0,car_hpos,BB_vpos+28); // pole
    tsl (0,car_hpos,BB_vpos+wheeldia/2) { // bearing
      color ("silver")  
        difference() { // bearing 608
          cylz (-22,7);
          cylz (-8+0.4,10); // +0.4 to compensate the diameter increase due to compensation
        }
      dmirrorz() 
        tsl (0,0,-4.5) {
          color ("red") 
            BBcentring(); 
          color("silver")
            cylz(diamNut4,-3, 0,0,0,  6);
        }  
    }  
    
  tsl (0,car_hpos,car_ht+car_vpos+0.1) 
    color ("red") car_spreader();   // car transversal bar for car support rod 
}

module bellow() { // very rough simulation of inter-car bellow
  color ("black")
    tsl (0,0,38)
      hull() 
        dmirrory() dmirrorz() cylx (-12,carspace,0,18,38);  
}


module rail_support(dual=false, circ_way=false) {
  wd = (dual)? 16:9;
  btoffset = (dual)? 4:0;
  way_hoffset=(circ_way)?diam_way/2-9:beam_width/2-10; 
  bext = beam_width/2+way_hoffset;
  if (circ_way)  tsl (0,way_hoffset,ppw_vpos)  
    difference() {
      union() {
        rot (0,90)
          sectorz (160, 230)
            cylz (-diam_way-4,wd, 0,0,-wd/2, 50);
          cubey(wd,7.5,7,  -wd/2,-3.75-way_hoffset,diam_way/2+2); 
          cubey(wd,12.8,2,  -wd/2,-way_hoffset,diam_way/2+1.1); 
      }  
      cubey(wd+2,8,7,  -wd/2,-4-way_hoffset,-ppw_vpos+1.5);
      cylx (-diam_way-0.1,66,  0,0,0, 50);
      cylx (-8,66,            0,-way_hoffset,-ppw_vpos, 50);
      
      cone3z (6.5,3, -5,1.7,5,  -4.5, -way_hoffset, -ppw_vpos-5.6,32);
      cone3z (3,6.5, -5,1.7,5,  -4.5, -way_hoffset+9, -ppw_vpos-5.8,32);
    }  
  else  // rectangular way
    difference() { 
      union() {
        cubez (wd, 6.5, -railbeamdist);
        cubey (wd, bext+5, 2,  0,-5,-railbeamdist+1);
        cubez (wd, 9, 1.8,   0,7,-railbeamdist+1);
        cubey (wd, 1.5, 2.2, 0,bext,-railbeamdist-1);
        cylx (-4,wd, 0,bext-0.5, -railbeamdist, $fn, 0);
      } // then whats removed  
      cubey (wd+4, -bext, -4,  0,bext,-railbeamdist-6);
      cylx (-8.1,25, -btoffset); // rail cut
      dmirrorx() {
        cone3z (3.8,7,  -5,1.8,5,  -btoffset,7,-railbeamdist+1);
        cone3z (6.5,3, -1.5,1.7,5, -btoffset, 0,-railbeamdist+0.2,32);
      }  
    }
}

module sbogie_h() { // non motor bogie beam
  lg = wheel_space+11;
  lg2 = wheel_space-wheeldia-4.6;
  difference () {
    union() {
      cubex (lg2,8, barht,   -lg2/2,4.1);
      hull() {
        dmirrorx() 
          cyly (barht,6,  wheel_space/2,7,0, $fn ,0); // last '0' neutralise holeplay
        cubex (lg,6,barht/2, -lg/2,10,barht/4);
      }  
    }  
    dmirrorx() {
      cyly (10+plb,5,  wheel_space/2,6);
      cyly (3+plb,6,   wheel_space/2,6);
      cyly (-4+plb,66,   8,      6);
    }  
  }
  if ($pad) 
    dmirrorx()
     cylz (12,0.7, lg/2,10,6.3);
}

module sbogie_h1() {  //  non motor bogie beam with brush support
  lg2 = wheel_space-wheeldia-4;
  difference() {
    union() {
      sbogie_h();
      dmirrorx() { // vertical bar attach
        hull() { // brush support
          cone3x (6,4, 5.5,1.5,0, 12,5,6-wheeldia/2);
          cubex(3.7,12.8,2, 12,6.5,14-wheeldia/2);
        }
        // cyly (44,8, wheel_space/2,0,0, 50); //check passage
        if ($ssw)
          hull() { // self-switch attach
            cylx (9,-3,    lg2/2,0,barht/2+4.5);
            cylx (9,-3,    lg2/2,3,barht/2+4.5);
            cubez(3,12,6,  lg2/2-1.5,6.55,barht/2-0.05);
          }
      }  
    }
    rot (25)
      cubez(222,10,20,  0,18,-5);
    cylx (-2,66, 0,5,6-wheeldia/2); // brush articulation hole
    cylx (-4,66, lg2/2,0, barht/2+4.5); // self-switch arti
    dmirrorx() 
      cyly (10.5,4,  8,10.5);
  }
  if ($pad) 
    dmirrorx()
     cylz (12,0.7, wheel_space/2+6,10,6.3);
}

module sbogie_h2() { // non motor bogie beam, open side, with support
  difference () {
    union() {
      dmirrory(false) sbogie_h();
      difference() {
        dmirrorx() { // vertical bar attach
          hull() {
            cubey (3.5,-14,barht,  12.15+1.75,-6,0); // 1.5 (half thick) +0.15 play
            cylx (11.5,3.5,  12.15,-18.5); 
            cylx (13.5,3.5,    12.15,-23,-17); 
          }
        }
        hull() {
          cylx (-6,66,   0, -5,11-wheeldia/2);
          cylx (-10,66,  0, -9.2,6-wheeldia/2,  50);
          cylx (-6,66,   0, -14.6,-3-wheeldia/2);
        }
      }
    } // then whats removed
    cylx (-4,66, 0,-18.5); // attach holes
    cylx (-4,66, 0,-23,-17);
    dmirrorx() 
      tsl (8,-13.5,0)
        rot(0,30) cyly (diamNut4,4.5,   0,0,0,6);
  }  
}

module side_arm(motor=false) { // draft on a xy plane
  thk = 12;
  difference() {
    union () {
      hull() {
        if (motor)
          cylz (11.5,thk, -32,-9-23.5);
          //cubez (15,4,thk,   -16,-37);
        else {
          cylz (11.5,thk,       0,-18.5);
          cubez (23,1.5,thk, -4.5,-13.1);
        }  
        difference() {
          cylz (55,thk,  BB_vpos+22,-9.5,0,60);
          cubez (50,100,thk+2, -10,-20,-1);
        }  
      }
      hull() { // bearing beam
        cylz (11,thk,     BB_vpos,13.5+car_hpos);
        cubez (11,10,thk, BB_vpos,-5);
      }  
    } // then whats removed
    cubez (50,50,100, 0,11.5,-1); // flatten the fixation
    if (motor) {
      cylz (-35,66, -mtshaftdist, -23.5,0,50); // motor reservation
      cylz (-4,299, -32,-9-23.5); // fixation holes
      cylz (-4,299, -51,-6.5-23.5);  
    }  
     dmirrorz() 
      cyly (4,8,   0,-15.5,8);
    hull () { //internal cut
      if (motor) { // cut for motor bottom gusset
        cylz (-2,66,   -6,-28);
        cylz (-20,66, -32,-17);
      }  
      else  
        cylz (-2,66,   -6,-11.5);
      cylz (-35,66, BB_vpos+23,-6,0,60);
      cylz (-6,66,  BB_vpos+8.5,25);
      cylz (-6,66,  BB_vpos+48.5,25);
    }
    cylz (-4,66,   0,-18.5); // attach holes
    cylz (-4,66, -17,-23);
    cylx (-22,7,  BB_vpos,car_hpos,0, 50); // bearing space
    cylx (-18,33, BB_vpos,car_hpos); // bearing axis
    dupl ([0.5,-27,0]) {
      cylz (-3-plb,66,  BB_vpos,13.5+car_hpos); //bearing assembly hole
      cylz (diamNut3,3, BB_vpos,13.5+car_hpos,thk-2.7,6); // nut hole - need support ?
    }  
  }
}

module barbrush() {
  axpos = -8.86;
  difference() {
    union() {
       hull() {
         cylx (-5,23.5, 0,5,6); 
         cylx (-5,23.5, 0,0,9); // 
         cylx (-5,23.5, 0,-6.45,7.5); //
         cylx (-6,23.5, 0,axpos,3.5); // 
       }
       hull() {
         cylx (-6,44, 0,axpos,3.5); // 
        // cylx (-6,44, 0,axpos-2.65,0); // 
       }  
       dmirrorx() {
         hull() {
           cylx (6,6, 16,axpos,3.5); // 
           cylx (5,7, 27,brushAxisHt-4,-13); // 
         }
         hull() {
           cylx (5,7, 27,brushAxisHt-4,-13); // 
           cylx (5,8, 26,brushAxisHt-1,brushAxis); // 
         }
         hull() {
           cylx (5,8, 26,brushAxisHt-1,brushAxis); // 
           cylx (5,8, 26,brushAxisHt,brushAxis); // 
         }
       }  
    } // then whats removed
    hull() {
      cylx (-9,66, 0,8,-3.5); // 
      cylx (-9,66, 0,-1.5,1.5); //
      cylx (-9,66, 0,-8.5,-8); //
    }  
    cylx (-2,66,  0,5,6); // brush articulation hole
    cylx (-2,111,  20,brushAxisHt,brushAxis); // brush pad articulation hole
    hull () duply (5) 
      cylx (-1.65,111,  20,brushAxisHt,brushAxis); // brush pad articulation hole
    cylx (-2.5,111,  20,brushAxisHt+2.7,brushAxis); // brush pad articulation hole
    dmirrorx()
      rot (-10.5,-5) hull () { // passage for spring
        cylz (-1.4, 66, 28,-19.5);  
        cylz (-1.4, 66, 28,-23);  
      }
  }  
}

module brushpad() {
  intersection() {
    cylz (550, 100, -30,-269.7,-50,200);  
    difference () {
      union() {
        cubey (29,2,18, 0,1.5,0);   
        rotz(-7)
          cubey (14,1.9,18, 7.2,1.6,0);
        dmirrorx() hull() {
          cylx  (6,2.8,   4.2);
          cubey (2.8,2,12, 4.2+1.4,1,-3);     
        }  
      } // then whats removed
      cylx (-2,16); // brush pad articulation hole 
      hull() {
        cylx  (-6.8,8.4);
        cylx  (-6.8,8.4, 0,6);
      }  
      dmirrorx() dmirrorz() {
        cubey (1.5,33,3.5, 11.5,0,5.4);   
        cubey (1.5,33,3.5, 8,0,3.9);   
      }  
    }
  }
  if($pad) 
    dmirrorx() 
      cylz (10,0.7, 14,1.5,-9);
}


module brushpadold() {
  difference () {
    union() {
      hull() 
        dmirrorx() dmirrorz() 
          cyly(3,1.5, 13.5,2,7.5);    
      dmirrorx() {
        cylx  (6,2.8,   4.2);
        cubey (2.8,3,6.2, 4.2+1.4,0);     
      }  
    } // then whats removed
    cylx (-2,66); // brush pad articulation hole 
    hull() {
      cylx  (-6.8,8.4);
      cylx  (-6.8,8.4, 0,6);
    }  
    dmirrorx() dmirrorz() {
      //cyly (-2.5,33, 7,0,5);
      
      hull() {
        cyly (-1.6,33, 11.8,0,2.5);
        cyly (-1.6,33, 11.8,0,5.3);
      }
      hull() {
        cyly (-1.6,33, 8,0,4);
        cyly (-1.6,33, 8,0,6.8);
      }
    }  
  }
}


module barsep (horiz=false, wd=12.8, circ_way=false) { // separating attach. for way suspension from top or switch
  //beam_width = 27;
  way_hoffset=(circ_way)?diam_way/2-9:beam_width/2-10; 
  dtw = beam_width/2-8.5+way_hoffset;
  dtopw = wtopbeam/2-8.5;
  tsl (0,8.5,19) // reference is the top of the bottom beam
    difference() { 
      union() {
        hull() {
          cylx (-25,wd,  0,-6+dtopw,26.5, 32);          
          cylx (-35,wd,  0, 6,        14, 32); 
          cylx (-35,wd,  0, 6,        -3, 32); 
          cylx (-25,wd,  0,-6+dtw, -26.5, 32);          
          if (circ_way)
            cylx (-5,wd,  0,diam_way/2+way_hoffset-8.5-0.5, ppw_vpos-19-2, 32);          
        } 
        if (!circ_way) mirrorz() hull() {
          cubey(wd,7,2,  0,dtw,25);   
          cubey(wd,4,20, 0,dtw,42);   
        } 
        if (horiz) {
          hull() {
            cylx (-10,wd, 0,7,27+7,   32);  
            cylx (-10,wd, 0,-19,27+7, 32);  
          }
          rot(36) cubey(wd,7,18, 0,23.5,15);   
        }
        else 
          hull() {
            cubey(wd,7,2,  0,dtopw,25);   
            cubey(wd,4,20, 0,dtopw,42);   
          }
          
      } // then whats removed
      
      cubey(66,-40,100,  0,-8.5,-23);
      
      hull() {
        cylx (-12,66,  0,-22,     23.5);          
        cylx (-12,66,  0,-5+dtopw,21);          
        cylx (-18,66,  0,2,       14); 
        cylx (-18,66,  0,2 ,     -3); 
        cylx (-12,66,  0,-7+dtw, -21);          
        cylx (-12,66,  0,-22,    -23.5);          
      } 
      if (horiz) {
        cylx (-4,66,  0,7  ,27+7);
        cylx (-4,66,  0,-19,27+7);
      }
      else {
        cubey(66,-40,40,  0,-0.05+dtopw,47);  // so distance is 2*27 = 54
        cubey(66,-20,20,  0,-2+dtopw,27+0.1); 
        duplz (10) // screw holes on top beam
          cone3y (3,6.5, -6,1.7,8,  0,dtopw+2,35);
      }  
      if (!horiz)  {
        dupl ([0,-2,12.5]) {
          cyly (-4,66,   0,0,33);
          tsl (0,3.7+dtopw,33) {
            rot (-90) cylinder (d1=3, d2=8, h=2.5);
            cyly (8,10,  0,2.45);
          }  
        } 
      }
      mirrorz() 
        dupl ([0,-2,12.5]) {
          cyly (-4,66,   0,0,33);
          tsl (0,3.7+dtw,33) {
            rot (-90) cylinder (d1=3, d2=8, h=2.5);
            cyly (8,10,  0,2.45);
          }  
      } 
      if (circ_way) tsl (0,way_hoffset-8.5,ppw_vpos-19){
        cylx (-diam_way-0.1,66, 0,0,0, 50);
        rot (-78)  // screw hole on circ beam - same in pipeseat()
          cone3z (3,6.5, -6,1.7,8,  0,0,diam_way/2+1,32);
      }  
      else {
        cubey(66,-40,40,  0,dtw-0.05,-47);
        cubey(66,-20,20,  0,-2+dtw,-27-0.1); 
        duplz (10) // screw holes on rail beam
          cone3y (3,6.5, -6,1.7,8,  0,dtw+2,-45);
      }  
    }
  if (circ_way) pipeseat(0,wd, circ_way); 
}

module pipeseat(x=0, wd=16, circ_way) {
  way_hoffset=(circ_way)?diam_way/2-9:beam_width/2-10; 
  wd2 = wd;
  tsl (x,way_hoffset,ppw_vpos)  
    difference() {
      union() {
        rot (0,90)
          sectorz (55, 225)
            cylz (-diam_way-4,wd2, 0,0,-wd2/2+wd/2, 50);
          cubey(wd2,7.5,7,  -wd2/2+wd/2,-3.75-way_hoffset,diam_way/2+2); 
        cubez(wd2,15.5,4,  -wd2/2+wd/2,way_hoffset+1,diam_way/2-1.9); 
      }  
      cylx (-diam_way-0.1,66,  0,0,0, 50);
      rot (-78) 
        cone3z (3,6.5, -5,1.7,5,  0,0,diam_way/2+1,32);
      cylx (-8,66,       0,-way_hoffset,-ppw_vpos, 50);
      cubey(wd+2,8,7,  0,-4-way_hoffset,-ppw_vpos+1.5);
      cylx (-diam_way-0.1,66,  0,0,0, 50);
      cylx (-8,66,            0,-way_hoffset,-ppw_vpos, 50);
      
      cone3z (6.5,3, -5,1.7,5,  0, -way_hoffset, -ppw_vpos-5.6,32);
      cone3z (3,6.5, -6,1.7,6,  0, -way_hoffset+9, -ppw_vpos-6,32);
    }
}


module barsep2() { // separating attach support. for way suspension from top or switch
  tsl (0,8.5,19)
    difference() {
      union() {  
        cubez (44,36,2.5, 0,-6,39.1);
        dmirrorx () 
          cubez (4,36,11, 8.1+2,-6,28.5);
      }
      cylx (-4, 66, 0,7,27+7);
      cylx (-4, 66, 0,-19,27+7);
      tsl (0,-6) {
        dmirrorx() {
          cylz (-4,99, 17);
          dmirrory ()
            cylz (-4,99, 17,10);
        }  
      }  
    }
}

module switch_hinge1() {
  difference() { // rail support
    cubez (15, 10, -railbeamdist, 4.3);
    cubez (17, 12, -railbeamdist+6.4,  4.3,0,0.01);
    cylx (-8.1,28);
    cone3z (9,4, 1,2.2,6, 5.5,0,-railbeamdist-0.1);
  }
  tsl (0,0,-railbeamdist)
    difference() { 
      union() {
        cubex (-3.2,14,28,  0,2,-13);
        cubex (2, 14, 1,    0,2,0.5);
        tsl (0,0,-4)
        duplz (-15,1) 
          hull () {
            cylz (7,-3, -7,0,0, $fn, 0);
            cubez (2,14,-3, -2.5,2);   
          }
      }
      cylz (-3, 66, -7); // articulation axis
      cone3x (9.5,4, 3,2.2,5, -6,2,-13);
      cone3z (9,4, 1,2.2,6, 5.5,0,-0.1);
    }
}

module switch_hinge2() {
  tsl (-6,0,-railbeamdist)
    dmirrorx(false) 
      tsl (8)  {
        difference() { 
          union() {
            cubex (-3.2,14,28, 0,2,-13);
            cubex (2,14,1,     0,2,0.5);
            tsl (0,0,-1)
            duplz (-15,1) 
              hull () {
                cylz (7,-3,     -7);
                cubez (2,14,-3, -2.5,2);   
              }
            cubez (15,10,railbeamdist,  4.3);  // rail support  
          } // then whats removed
          cubez (17, 12, -railbeamdist+6.4, 4,0,9.01);
          cylz (-3, 66, -7); // articulation axis
          cylx (-8.1,28, 0,0,railbeamdist); // rail cut
          cone3z (9,4, 1,2.2,6, 5.5,0,-0.1);          
          cone3x (9.5,4, 3,2.2,5, -6,2,-10);
        }
      }  
}

module BB_switch() { // BB - 625 5x16x5 - abandoned : 624 4x13x5 
  wd = 12;
  difference() { union() {
      cubez (26, wd,16,  13);
      cyly (-16,wd, 26,0,8);  
      cubez (1, wd,4,  -0.5,0,-1);
    }
    hull () {
      cyly (-12,33, 26,0,8);  
      cyly (-12,33, -3,0,8);  
    }
    cylz (-4,66, 12);
  }
  difference() { 
    union() {
      cubez (14, wd, 12, -2,0,4);
      cubez (15,wd,7,  34,0);  
    }
    cylx (-5,20, 0,0,8);
    cylz (-4,66, 37);
    tsl (21.5,0,3)  
      rot (0,45)
        cubez (10,66,12);  
  }  
}

module anchor() {
  difference() {  
    union() {
      cubex(-2,10,19);   
      cubex (-3,5,4,0,0,-7);
      cyly (-4,5,-3,0,-7);
    }  
    cyly (-1.5,66,-3,0,-7);
    cylx (-3,66,0,0,5.5);
    cylx (-3,66,0,0,-1.5);
  }  
}


module ball_arti() {
  difference() {
    union() {
      hull() {
        dmirrory() 
          cylx (-7.5,2.8, -carspace/2+1.4,8,10);
        cubez (2.8,12,1, -carspace/2+1.4,0,-6);  
      }  
      hull() {
        cylz (7,9, 0,0,-6);
        cubez (1,10,9, -carspace/2+2,0,-6);
      }
      hull() {
         cubez (1,8,6, -5.5,0,-3);
         cubez (1,10.2,7, -carspace/2+0.5,0,1);
      }
      tsl (0,0,7) {
        sphere (d=7, $fn=32);    
        cylz (7,-7, 0,0,0, 32, 0);
      } 
    *  if ($pad)  
        dmirrory() 
          cylz (9,0.6, -carspace/2+1.25,11, -6);
    } // then whats removed
    dmirrory() 
      cylx (-3,66, 0,8,10);
    cylx (2.4,-40, -8,0,-2.5);
  }    
}


module arti_template() {
  difference() {
    union() {
      cubez (1.5,24,21, 0.75,0,-7); 
      cubez (6,24,1.5, 3,0,-6+19.5); 
      dmirrory() {
      cylx (6,3.5, 0,8,-3);
      cylx (6,3.5, 0,8,10);
      }  
      cylx (6,3.5,  0,0,9);
      cylx (6,3.5, 0,0,-2.5);
    } // then whats removed
    dmirrory() {
      cylx (-2, 66, 0,8,-3);
      cylx (-2,66,  0,8,10);
    }  
    cylx (-2,66,  0,0,9);
    cylx (-2,66, 0,0,-2.5);
  } 
}

module ball_cup() {
  difference() {
    union() {
      hull() {
        dmirrory() 
          cylx (-7.5 ,2.8, carspace/2-1.4,8,-3);
        cubez (2.8,12,19, carspace/2-1.4,0,-6); 
      }   
      hull() {
         cubez (1,11.5,6,  0.5,0,7);
         cubez (1,10,14, carspace/2-0.5,0,-1);
      }
      hull() {
        cylz (11.5,7.5,   0,0,5.5, $fn,0);
        cubez (1,10,7.5, carspace/2-1,0,5.5);
      }  
      *if ($pad)  
        dmirrory() 
          cylz (9,0.6, carspace/2-1.25,11, 12.4);
    } // then whats removed
    tsl (0,0,7) {
       sphere (d=7.3, $fn=32);    
       tsl (0,0,-3.8)
         cylinder (d1=8.5, d2=7.27, h=4, $fn=32);
    }
    dmirrory() 
      cylx (-3, 66, 0,8,-3);
    cylx (2.4,22, 8,0,9);
  }    
}

module ball_cup_floor() {
  difference() {
    union() {
      cubez (carspace/2+26,8,7,  carspace/4+13,0,8);
      cylz  (11.5,7.5,  0,0,7.5);
    }
    tsl (0,0,10) {
      sphere (d=7.3, $fn=32);    
      tsl (0,0,-3.8)
        cylinder (d1=8.5, d2=7.27, h=4, $fn=32);
    }
    duplx (15)
      cyly (-3, 66,  carspace/2+6, 0, 11.5);
  }    
}

module ball_cup_floor2() {
  difference() {
    cubez (26,12,15,  carspace/2+13,0,0);
    hull() {
      cubez (50,8,12,  carspace/2+22,0,8);
      cylx (8,66,  0,0,6);
    }  
    duplx (15) {
      cyly (-3, 66,  carspace/2+6, 0, 11.5);
      cylz (-3, 66,  carspace/2+6);
    }  
  }
}

module ball_arti_floor() {
  difference() {    
    cubez (carspace/2+28,8,6, -carspace/4-14);
    duplz (-10.8)
      dmirrory() 
          rot (45) cubex (-100,10,10,  10,11.8,0);
  }  
  cylz (8,6);
  tsl (0,0,10) {
    sphere (d=7, $fn=32);    
    cylz (7,-7, 0,0,0, 32 ,0);
  }  
}

module slide_arti_floor() { // slider for floor articulation (to absorb car pitch)
  difference() {
    union() {
      hull()
        duplx (-18)
          dmirrory() 
            cylz (8,-2.2,  -4-carspace/2,12, 0, $fn,0);
      cubez (26,14.5,-8.8, -13-carspace/2);
    } // then whats removed
    cubez (30,8.6,-6.8, -13-carspace/2,0,0.2);
    duplx (-18)
      dmirrory() 
        cylz (-3,66,  -4-carspace/2,12);
  }  
}

module BBcentring () { // ball bearing centering ring 
  difference() {
    union() {
      cylz (8-2.2*holeplay,4); // holeplay increase diameter; so reduced twice
      cylz (12,1.2);
    }  
    cylz (4.1,6,  0,0,-1);
  }
}

module LGB_bogie() { // not used - for memory
  cubez (124, 34,45,0,-25,10);
  dmirrorx() 
    tsl (38,0,wheeldia/2) {
      rot (90)
        wheel();
      color ("grey") 
        cyly (-5,21);
    }  
}

module car_spreader (roofvpos=20){ //car sides spreader beam maintaining the bogie suspending rod
// it is adapted to the Newqida car bodies, may need modifications for other cars  
  beamwidth = 10;
  intcarwidth = 99; //width inside windows, add 3 for width inside body
  //cyly(-3,intcarwidth, 0,0,-8); // check width
  difference() {
    union() {
      hull() {
        cubez (beamwidth,9,-4,     0,0,roofvpos-4); // 4 for nut+washer
        dmirrory()
          cubez (beamwidth,2,-1.5,  0,-8,roofvpos-7);
      }  
      dmirrory() {
        hull() {
          cubez (beamwidth,2,-2,  0,intcarwidth/2+0.5,0);
          cubez (beamwidth,2,-2,  0,6,roofvpos-6);
        } 
        cubez (beamwidth,3,-5,     0,intcarwidth/2);
        cubez (beamwidth,2,-8,     0,intcarwidth/2-1);
      }
      if ($pad)
        dmirrory() 
          cylx (10,-0.6, beamwidth/2,intcarwidth/2+1,-4); 
    } // then whats removed
    cylz (4,   33);
    cyly (-3,  133,  0,0,-4);
    cyly (-6.5,intcarwidth-4,  0,0,-4);
  }  
}

module roof (lgroof=100) { // roof
  diarf = 240;
  color(roof_color)  tsl (0,0,car_ht) 
    difference() {
      intersection() {
        cubez (lgroof+6,car_wd+2,roof_ht+1, lgroof/2+0.05);
        cylx (diarf,lgroof+10, -4,0,-diarf/2+roof_ht, 100);
      }
      difference () {
        cylx (diarf-4,lgroof+9,  -4.5,0,-diarf/2+roof_ht, 100);  
        dmirrory()
          cubex (lgroof+10,20,50, -5,car_wd/2-2.5+10,10);
      }  
    }
}

module car(car_len=192, car_windows=4, clr="blue") {
  echo("car color", clr);
  diarf=240;
  module box() {  
    color(clr)  {tsl (0,0,car_ht/2)
     difference() {
       cubex (car_len,car_wd,car_ht);
       cubex (car_len-3,car_wd-3,car_ht, 1.5,0,1.5); 
     }  
     tsl (car_len/2)
       dmirrorx() 
         intersection() {
           cylx (diarf-4, 1, car_len/2-1 -0.05,0,-diarf/2+roof_ht+car_ht, 100);  
           cubex (10,car_wd-5,50, car_len/2-5,0,10+car_ht);
         }  
   } 
  }
  difference() {
    box(); 
    dmirrory() // holes for windows
      duplx (winspace,car_windows-1) 
        cubey (34,5,40,winspace/2,car_wd/2-0.1,62);
    tsl (car_len/2) 
      dmirrorx()  // hole for door window
       cubex (5,24,40,car_len/2-0.1,door_offset,57);
  }
  roof (car_len); 
  color (car_struct_color) {    
    cubez (car_len,car_wd,-0.2,car_len/2);
    dmirrory () 
      cubez (car_len,11.5,-11.5,  car_len/2,32.5); 
  }  
  winspace = car_len/car_windows; 
  dmirrory()
    duplx (winspace,car_windows-1) {
      color (winframe_color)
        difference() {
          cubey (34,1,40, winspace/2,car_wd/2-0.1,62);
          cubey (30,5,36, winspace/2,car_wd/2-1,62);
        }  
      color (clr_glass)  
        cubey (30,0.5,36,winspace/2,car_wd/2-0.2,62);
    } 
   tsl (car_len/2) 
   dmirrorx() tsl (0,door_offset)  {  // doors
     color (winframe_color) {
       difference() {
         cubex (1,32,80,  car_len/2-0.1,0,40);
         cubex (5,28,76,  car_len/2-1,0,40);
       }
       difference() {
         cubex (1,24,40,  car_len/2-0.1,0,57);
         cubex (5,20,36,  car_len/2-1,0,57);
       }
     }  
     color (clr_glass)  
       cubex (0.5,20,36,  car_len/2-0.2,0,57);
   }
  color ("white")
  cubez (car_len-55,78,-1,  car_len/2,0,-11.5);     
}

module platform(mirr=false, plen=45, clr=cabin_color) {
  htwin = 44;
  win_h = car_ht-htwin;
  win_cent = win_h+htwin/2;
  side_dec= 10;
  color (car_struct_color) { 
    difference() {
      union() {    
       cubez (plen,car_wd,1.7, plen/2,0,-0.2);
       dmirrory () 
         cubez (plen,11.5,-11.5, plen/2,32.5); 
      } 
      // then whats removed 
      if (mirr) 
        tsl (35,car_wd/2)
          rotz(-45)
            cubey (120,20,300);  
      else 
        tsl (0,car_wd/2)
          rotz(-12)
            cubey (120,20,300);  
      tsl (35,-car_wd/2)
        rotz(45)
          cubey (120,-20,300);  
    }
    duplz (30) 
      cylz (3,8,  1.5,-car_wd/2+1.2, 6); // door hinges  
  }
  color (clr) {
    hull () { // car face
      cubez (2,car_wd-2*side_dec,win_h, plen-0.8); 
      cubez (2,76,1, plen-0.8,0,-12);
    } 
    if (mirr) 
      tsl (0,car_wd/2)  // side panel
        cubez (35,2,win_h,  35/2, -1); 
    else  
     tsl (0,car_wd/2)  // side panel rotated
       rotz (-12)   
         cubez (plen+1,2,win_h,  plen/2+0.5, -1); 
    dmirrory (mirr)
      tsl (35,car_wd/2) // side angle panel   
        rotz (-45)   
          cubez (14,2,win_h,  7,-1+0.05); 
    if (!mirr) difference() { // separating panel
        cubez (plen-2,2,car_ht+roof_ht-3,  plen/2-1,9,0);
        cubey (plen-26,15,32, plen/2-7, 0, win_cent);
        cubey (8,5,40,        plen/2+14,6,win_cent);
    }
    cubez (29,1.5,win_h-3,  15, -car_wd/2+0.75,3); //access  door
    cubez (5,1.5,win_h,  32.5, -car_wd/2+0.75-0.05); //small side panel for door  
  } 
  if (!mirr) { 
    color (winframe_color) {
      tsl (plen-1.5,28+8-side_dec, car_ht) // front glass frame
        difference() {
          cubez (2,38,-htwin);
          tsl (-1,0,-2)
            cubez (5,34,-htwin+4);
        }
      tsl (0,car_wd/2) // side glass frame
        rotz(-12)  
          difference() {
            cubey (plen,2,htwin, plen/2+0.5,-2,win_cent);
            cubey (plen-4,5,htwin-4, plen/2+0.5,-1,win_cent);
          } 
      difference() { // engineer door glass frame
        cubey (plen-22,1,htwin-8,plen/2-7,7,win_cent);
        cubey (plen-26,5,htwin-12,plen/2-7,6,win_cent);
      }
      difference() { // engineer door frame
        cubey (plen-16,1,car_ht-2, plen/2-7, 7-0.1,car_ht/2-1);
        cubey (plen-20,5,car_ht-6, plen/2-7, 6,car_ht/2-1);
      }
      difference() { // separating glass frame
        cubey (12,1,htwin,plen/2+14,7,win_cent);
        cubey (8,5,htwin-4,plen/2+14,6,win_cent);
      }
    }   
    color (clr_glass) {    
      tsl (plen-2.5,34-side_dec+2,car_ht-2)
        cubez (1,34,-htwin+4);
      tsl (0,car_wd/2)
        rotz(-12)  
          cubey (plen-4,-1,htwin-4,plen/2+0.5,-1,win_cent);
      cubey (plen-26,1,htwin-12,plen/2-7,7,win_cent);
      cubey (8,1,htwin-4,plen/2+14,7,win_cent);
    }  
  }
  roof (plen+4);
}

module platform_plates(plen, mirr) {
  rtx = (mirr) ?180:0;
  rotz(rtx) { 
    txtgt = ["Garden Monorail", "Open Monday to Sunday:","6:30 to 22:30","www.rouzeau.net/GardenTrain/Monorail"];
    tsl (plen,0,25) rot (90,0,90) plate(txtgt, "white",70,26);  // front plate
    tsl (plen,0,-5) rot (90,0,90) plate(["PRZ Industries"],"black", 34,10,1.5); //manuf plate
  }
  carnum(plen-2, mirr); // number plate ??
}

module wheel(slot=0, half=false ,clr = "grey") { // if slot have a value, this is the motor wheel
  dishaft = (slot) ?6:3; 
  $fn=50;
  color (clr) 
  difference() { 
    union() { 
      difference() {
        rotate_extrude($fn=80) {
          difference() {
            union() {
              tsl (dishaft/2+holeplay/2,-5.5)
                square ([wheeldia/2+1.5-dishaft/2,11]); 
             *tsl (dishaft/2+holeplay/2,-6)
                square ([2,11.5]); 
            } // then whats removed 
            tsl (wheeldia/2) {  
              circle (d= 8.2, $fn=32); // groove
              dmirrory () 
                rotz (8)
                  tsl (0,0.07)
                    //cubex(10,4,4);
                    square ([10,4]);
              if (slot) {
                tsl (-slot/4-4.1)
                  circle (d= slot, $fn=32); 
                tsl (-slot/4-4.1,-slot/2)
                  square([4,slot]);
              }  
            }
          }
        } // then whats removed
        cubez (50,50,50);
      } 
      if (!half) {
        cylz (27-2*holeplay, 6); // Central part integral because else hole alignment difficulties
        cylz (7, 6.8);
      }  
    }// 2nd removal
    cylz (-dishaft,66);
    if (half) 
      cylz (27,-20,  0,0,0.1);
    intersection() { 
      for (i=[0:5])
        rotz (i*60) 
          hull() {
            dmirrorx() 
              cylz (-3,22, 2.7,10);
            cylz (-6,22, 0,9.5);
            if (slot) 
              cylz (-5,22, 0,7.6);
            else   
              cylz (-2.8,22, 0,5.5);
          }
      cylz (-23.8,24);
    }     
  } 
  if (slot && !half) // flats to lock wheel rotation
    dmirrorx () 
      cubez (1,8,-6.35, -0.5-2.2,0,1.35-0.5);
} 

module plate (txt=["Bonjour"], clr = "white", wd = 50, ht = 30, thk= 1.6, txth=3) {
  diamcorn = 0.08;
  dcn = diamcorn *wd;
  dci = dcn*0.5;
  difference() {
    union() {
      color ("gold")
      difference() {
        hull() 
          dmirrorx() dmirrory() cylz (dcn,thk, (wd-dcn)/2, (ht-dcn)/2);     
        hull() 
          dmirrorx() dmirrory() cylz (dci,thk, (wd-dcn)/2, (ht-dcn)/2, thk/2);     
      }
      if (len(txt)>1)
        color ("black")  
        tsl (0,ht/2-2.3*txth,thk/2)
          mutiline(txt, txth); 
      else
        color ("gold")  
          textz(txt[0],txth,thk/2+0.1,false,0,0,thk/2-0.1, "center", "center");
      color ("gold")  
        dmirrorx() dmirrory() cylz (dcn,thk, (wd-dcn)/2, (ht-dcn)/2);     
    if (clr)
      color (clr) 
        hull() 
          dmirrorx() dmirrory() cylz (dci,0.2, (wd-dcn)/2, (ht-dcn)/2, thk/2);      
    }
    dmirrorx() dmirrory() cylz (-dcn/3,66, (wd-dcn)/2, (ht-dcn)/2);
  }
  if (clr)  
    color ("silver") // rivets
      dmirrorx() dmirrory() cylz (dcn/2.3,1.9, (wd-dcn)/2, (ht-dcn)/2);     
}

module mutiline(ttext, txtsize, htext=0.5) { //text in 'z' axis
  ltxt = len(ttext);
  color ("black") { // the writing on the wall
    for (i=[0:ltxt-1]) {
      txs=(i==ltxt-1)?txtsize*0.8:txtsize; // last line is smaller size (license)
      tsl (0, -1.5*txtsize*i)
        textz(ttext[i], txs, htext, (i==0),0,0,"center","center");  //(i==0) bold the first line
    }
  } 
}

module carnum(lg, mirr) {
  mi = (mirr) ? 1:0;
  sgn = (mirr) ? -1:1;
  diarf = 240;
  mirror([mi,0,0]) 
    color("white")  tsl (0,0,car_ht) 
      intersection() {
        cubez (1,36,roof_ht, lg-0.05+0.5, 26, -2);
        cylx (diarf-5, 1, lg -0.05,0,-diarf/2+roof_ht, 100);
      }  
  color("black")  
  tsl (sgn*(lg-0.05), 18,95)  
    textx(17, 9, sgn*1.5, true,0,0,"center","center");   
}

module way_side_support() {
  color ("yellow") {
    way_side_support1();
    way_side_support2();
    way_side_support3();
  }  
}

module way_side_support1(swd=12.8, circ_way=false) {
  way_hoffset=(circ_way)?diam_way/2-9:beam_width/2-10; 
  dtw = (circ_way) ? diam_way*0.34+way_hoffset : beam_width/2+way_hoffset;
  ext = (circ_way) ? 28:25; // extent of the support
  difference() {
    union() {
      if (!circ_way)
        cubez (swd,2,-23, 0,dtw+1,-railbeamdist+1); 
      cubez (swd,3,-1,  0,dtw+0.5,-railbeamdist+1); 
      cubez (swd,ext,-2, 0,dtw+ext/2,-railbeamdist+1); 
      dmirrorx() 
        hull() {
          cubez (2, ext,-2, swd/2-1, dtw+ext/2,-railbeamdist+1);      cubez (2, 1.5,-1, swd/2-1, dtw+1,-railbeamdist+1-20); 
        }
    }
    hull() { // screw oval hole
      cylz (-3,99, 0,dtw+ext/2+3);  
      cylz (-3,99, 0,dtw+ext/2-3);  
    }
    if (circ_way) 
      cylx (-diam_way-0.1,66,  0,way_hoffset,ppw_vpos, 50);
    else
      duplz (-10)
        cyly (4,99, 0,0,-15);
  }
  if (circ_way) pipeseat(0, swd, circ_way);
}

module way_side_support2(swd=12.8) {
  dtw = (pipe_way) ? diam_way*0.34+way_hoffset : beam_width/2+way_hoffset;
  hlpos = (pipe_way) ?28:25;
  ext = distpylon+4-dtw-hlpos/2;
  difference() {
    union() {
      cubez (swd-4.2+5,2,-35, 0,distpylon-1-2.1,-railbeamdist-1.2); 
      cubez (swd-4.2,ext,-2, 0,distpylon-ext/2-2.1,-railbeamdist-1.2); 
      dmirrorx() 
        hull() {
          cubez (1.5, ext,-2, swd/2-0.75-2.1, distpylon-ext/2-2.1,-railbeamdist-1.2);           
          cubez (1.5, 1.5,-1, swd/2-0.75-2.1, distpylon-1-2.1,-railbeamdist+1-32); 
        }
    } // then whats removed
    cylz (-3,99, 0,distpylon-8);
    cylz (-3,99, 0,hlpos/2+dtw);
    cyly (9,99, 0,0,-45);
  }
}

module way_side_support3(swd=12.8) {
  difference() {
    union() {
      cubey (swd-4.2+5+4.2,-2,51, 0,distpylon,-railbeamdist+5-25); 
      dmirrorx()
        difference() {
          cyly (9.8,-7,   9,distpylon,-railbeamdist+2);   
          tsl (8,distpylon,-railbeamdist)
             cubex(-7,20,20);  
        }  
      cubez (swd+11,7,-3, 0,distpylon-3.5,-railbeamdist+7);   
      hull() {
        cubez (swd-1,7,-3, 0,distpylon-3.5,-railbeamdist+7); 
        cylz (7,-3, 0,distpylon-8, -railbeamdist+7);
      }  
      dmirrorx() {
        cubey (2,-7,43, swd/2-2.1+2.5+1.1,distpylon,-railbeamdist+5-21); 
        cubez (3.1,2.5,-31, swd/2-0.5,distpylon-5.5-0.1,-railbeamdist+4.9); 
      }  
    } // then whats removed
    cylz (-3,99, 0,distpylon-8);
    cyly (4,99, 0,0,-50);
    dmirrorx()
      cyly (-4,33, 9, distpylon-2,-railbeamdist+2);   
  }  
}

module profile_U (wd, ht, thk, lg) {
  difference () {
    cubex (lg, wd, ht, 0,0,0);  
    cubex (lg+10, wd-2*thk, ht, -5,0,thk);  
  }
}

module self_switch(ang=0) { // servo rotation 100
  sideo = 9;
  sswd = 25.5;
  color ("grey")
    tsl (0,-5.25,56.5)
      profile_U (11.5, 11.5, 1, 2500);
  tsl (150,0,sswaxis)
    duplx (345) {
      rot (ang) 
        ssw(76,sswd, sideo, -ang*1.09);//ssw axis on ordinary bogie
      tsl (-18,-22.5,-28.5)  
        rot (ang*0.55+10) sswgusset(); 
      tsl (-31,-20,-75) {
        rot (-90)
         rot (0,90) servo();     
        rot (1.11*ang) {
          hull() {
            cylx (6,4, 10);
            cylx (4,4, 10, -5.5,10.5);
          }
          tsl (14, -5.5, 10.5)
            rot (-1.355*ang)
              difference() {
                hull() {
                  cylx (5,3, 0);
                  cylx (5,3, 0,-17,32.5);
                }
                cylx (-2.5,99, 0,-17,32.5);
              }
        }  
      }  
    }
  tsl (150+713+345, 0, sswaxis) 
    rot (ang) 
       ssw(110,sswd,sideo, -ang*1.09);//ssw axis on motor
}  

module ssw(whssp=76, sswd, sideo, ang=0) { // side switch beam
  wheelvpos = 40;
  difference() { 
    union() {  
      dmirrorx() 
        tsl (whssp/2,0,wheelvpos)
          rot(-90)
            scale (0.6) wheel();
      color ("magenta") {
        hull() {
          cylx (-9,sswd);
          cylx (-10,sswd,  0,sideo,12);
        }
        hull() {
          cylx (-9,sswd);
          cubex (sswd,2,1.5,  -sswd/2,12,-3.75);
        }  
        hull() {
          cylx (-10,sswd, 0,sideo,12);
          cylx (-10,sswd, 0,sideo,32);
        }  
        hull () {
          dmirrorx() 
            cyly (-12,10, whssp/2,sideo,wheelvpos);   
          cyly (-12,10, 0,sideo,18);   
        } 
        if (whssp> 80) { // it is the motor bogie
          hull() { 
            cylx (-7,15,  -42,1,15); 
            cylx (-7,15,  -42,8,17); 
          }
          hull() { 
            cylx (-7,15,  -42,8,35); 
            cylx (-7,15,  -42,8,17); 
          }  
        }  
        else 
           cylx (-7,sswd, 0,1,15); 
      }
    }
    cylx (-4,66);  
    cylx (-3,66, 0,1,15); 
  }
  dtl = (whssp>80)?-52:-15; 
  tsl (dtl,1, 15)
    rot (ang*0.965)
    difference() {
      hull() {
        cylx (-5,5); 
        cylx (-5,5,  0,-27.7,-19); 
      }
      cylx (-2.5,66, 0,-27.7,-19); 
    }  
}  

module sswgusset () {
   difference () { 
     union() {
       hull () {
          cylx (-9,2);
          cylx (-5,2,  0,0,25);
       }
       hull () {
          cylx (-9,2);
          cylx (-5,2,  0,-20,0);
       }  
       cylx (-7, 4);
     }
     cylx (-2.5,99,  0,0,25);
     cylx (-2.5,99,  0,-20,0);
     cylx (-4,  99);
   }
   *cylx (-4,21);
}

module servo(){ //~ HS82 servo
	difference(){			
		union(){
      color ("darkgrey") {
        cubez(29.72,11.93,26,  -4.86,0,-19.81);
        cubez(40.64,11.93,2, -4.86,0,0);
        cylz (11.5,9.65);
        cubez(5,5.6,9.65, -5.86);		
      }  
			color("white") cylz(4.7,13);				
		} // then whats removed
    tsl (-4.86)
      dmirrorx()
			  cylz(-4.4,22,  18.03);
	}
}

*tsl (0,0,75)
  profile_handle (2500) ;