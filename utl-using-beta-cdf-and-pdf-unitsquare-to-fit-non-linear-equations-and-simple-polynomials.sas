%let pgm=utl-using-beta-cdf-and-pdf-unitsquare-to-fit-non-linear-equations-and-simple-polynomials;

Using beta cdf and pdf unitsquare to fit non linear equations and simple polynomials

github
https://tinyurl.com/yc5euh7k
https://github.com/rogerjdeangelis/utl-using-beta-cdf-and-pdf-unitsquare-to-fit-non-linear-equations-and-simple-polynomials

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

   SOLUTIONS

         1. You can use the beta to fit difficult non-linear equations
            A two parameter 'beta' is a much better fit then a 5th order polynomial in this case

         2, You can also fit nice polynomial equations with the beta.
            Both the 2 parameted beta and the 2 parameter polynomial fit 'equally' well.

/*                                                          _ _
/ |  _ __ ___   ___  ___ ___ _   _  _ __   ___  _ __       | (_)_ __   ___  __ _ _ __
| | | `_ ` _ \ / _ \/ __/ __| | | || `_ \ / _ \| `_ \ _____| | | `_ \ / _ \/ _` | `__|
| | | | | | | |  __/\__ \__ \ |_| || | | | (_) | | | |_____| | | | | |  __/ (_| | |
|_| |_| |_| |_|\___||___/___/\__, ||_| |_|\___/|_| |_|     |_|_|_| |_|\___|\__,_|_|
 _                   _       |___/
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

data have;
  input x y @@;
cards4;
0.0000 0.000 0.0021 0.204 0.0025 0.210 0.0026 0.211 0.0031 0.217 0.0033 0.219
0.0040 0.225 0.0057 0.238 0.0058 0.238 0.0087 0.253 0.0099 0.258 0.0106 0.247
0.0111 0.241 0.0136 0.257 0.0324 0.324 0.0446 0.322 0.0451 0.307 0.0621 0.376
0.0648 0.348 0.0888 0.364 0.1805 0.393 0.2494 0.437 0.2511 0.466 0.3680 0.449
0.4564 0.488 0.4601 0.537 0.4637 0.465 0.5522 0.496 0.5523 0.531 0.5590 0.508
0.5769 0.496 0.5887 0.502 0.5972 0.523 0.5984 0.535 0.6036 0.559 0.6045 0.519
0.6302 0.541 0.6356 0.523 0.6614 0.529 0.6860 0.567 0.7001 0.558 0.7249 0.587
0.7332 0.573 0.7359 0.543 0.7493 0.575 0.7777 0.567 0.7893 0.624 0.8428 0.582
0.8629 0.602 0.8659 0.589 0.8668 0.575 0.8792 0.607 0.8822 0.620 0.8836 0.618
0.8966 0.648 0.8982 0.654 0.9054 0.601 0.9719 0.710 0.9901 0.742 0.9914 0.747
0.9922 0.751 0.9936 0.758 0.9937 0.759 0.9952 0.768 0.9954 0.770 0.9972 0.787
0.9973 0.788 0.9980 0.797 0.9990 0.817 0.9999 0.871 1.0000 0.994
;;;;
 run;quit;

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/


     proc nlin data=have method=MARQUARDT          proc nlin data=have method=MARQUARDT
       CONVERGE=0.001;                               CONVERGE=0.001;
       parms A = 1                                   parms A = 1
             B = 1                                         B = 1
             ;                                             C = 1
       model y=CDF('BETA',x,a,b);                          D = 1
       output out=roger p=predicted;                       E = 1
     run;quit;                                             ;
                                                     model y=x + a*x**2 + b*x**3 + c*x**4
                                                        + d*x**5 + e*x**6;

                                                     output out=roger p=predicted;
                                                   run;quit;

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/
            MSE=0.000273 (2 parameters)                  MSE=0.0159 (5 parameters)

                         X                                             X
     0.0                0.5                1.0     0.0                0.5                1.0
  Y  -+------------------+------------------+-  Y  -+------------------+------------------+- Y
     |                                       |     |                                       |
     | 2 PARAMETER BETA MSE=0.000273         |     | 5 Parameter polynonomial MSE=0.0159   |
     |                                       |     |                                       |
     |  model y=CDF('BETA',x,a,b);           |     | model y=x + a*x**2 + b*x**3 + c*x**4  |
   1 +                                      X+   1 +     + d*x**5 + e*x**6;                + 1
     |                             Mean      |     |                                       |
     |  Source             DF    Square      |     |                            Mean       |
     |                                       |     |  Source             DF   Square       |
     |  Model               2   10.6633     X|     |                                      .|
     |  Error              69  0.000273     X|     |  Model               5   4.0611      X|
 0.8 +  Uncorrected Total  71               X+ 0.8 +  Error              66   0.0158      X+ 0.8
     |                                      X|     |  Uncorrected Total  71  21.3455      X|
     |                                      X|     |                                      .|
     |  X = predicted                      X |     |  X=predicted                        X |
     |  . = observed                    .    |     |  . observed                      .    |
     |                              .  XX    |     |                              .   .    |
 0.6 + A = 0.1502                 .   XX.    + 0.6 +                            X X XXX    + 0.6
     | B = 0.1500            .  .XX X ..     |     |                       . XXX. . ..     |
     |                 .   .XXXXX .          |     |         XX   X  .   . .X.  .          |
     |                 XX  X.                |     |                 .   XXX               |
     |          .   X   .                    |     |       X  .      XX  X                 |
     |         XX   .                        |     |         .    .                        |
 0.4 +       X                               + 0.4 +       .                               + 0.4
     |  .X                                   |     |  ..                                   |
     | .X                                    |     | ..        Paramete Estimate           |
     | X.          X        Y                |     |  .                                    |
     |XX                                     |     |..         A        27.9150            |
     |X      1   0.0000    0.000             |     |.          B          -159.7           |
 0.2 +X      2   0.0021    0.204             + 0.2 +.  X       C           335.7           + 0.2
     |       3   0.0025    0.210             |     |           D          -309.7           |
     |       ...                             |     |  X        E           105.6           |
     |      69   0.9990    0.817             |     |  X                                    |
     |      70   0.9999    0.871             |     | X                                     |
     |      71   1.0000    0.994             |     | X                                     |
   0 +x                                      +  0  +X                                      +  0
     -+------------------+------------------+-     -+------------------+------------------+-
     0.0                0.5                1.0     0.0                0.5                1.0
                         X                                             X

/*___                _                             _       _
|___ \   _ __   ___ | |_   _ _ __   ___  _ __ ___ (_) __ _| |
  __) | | `_ \ / _ \| | | | | `_ \ / _ \| `_ ` _ \| |/ _` | |
 / __/  | |_) | (_) | | |_| | | | | (_) | | | | | | | (_| | |
|_____| | .__/ \___/|_|\__, |_| |_|\___/|_| |_| |_|_|\__,_|_|
 _      |_|          _  |___/
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/


options ls=80 ps=44;
data havpoly;
  call streaminit(5432);
  do x=0.01 to 0.99 by .01;
    y=pdf('BETA',x,2,2) + rand('NORMAL',0,.1);
    output;
  end;
run;quit;

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

        proc nlin data=havpoly method=MARQUARDT       proc nlin data=havpoly method=MARQUARDT
          CONVERGE=0.001;                               CONVERGE=0.001;
          parms A = 1                                   parms A = 1
                B = 1                                         B = 1
                ;                                             ;
          model y=pdf('BETA',x,a,b);                    model y=a*x + b*x**2;

          output out=rogerpoly p=predicted;             output out=roger p=predicted;
        run;quit;                                     run;quit;

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

        Vertually equal fits both use only 2 parameters

                MSE= 0.0122 (2 parameters)                MSE= 0.0128 (two parameters)

                           X                                           X
        0.00     0.27     0.54     0.81     1.08      0.00    0.25    0.50    0.75    1.00
        --+--------+--------+--------+--------+--     --+-------+-------+-------+-------+---
      Y |                                       |     |                                    |
        |  Y=pdf('BETA',x,a,b)   MSE= 0.0122    |     | Y=a*x + b*x**2  MSE= 0.0128        |
        |                                       |     |                                    |
    2.0 +  A =  1.9250                          +     |                       Mean         |
        |  B =  1.9599                          | 2.0 +   Source       DF   Square         + 2.0
        |                                       |     |                                    |
        |  X=predicted    o                     |     |   Model         2  60.6344         |
        |  o=observed                           |     |   Error        97   0.0128         |
        |                   oo                  |     |   Uncorrected  99                  |
    1.5 +             ooXXXXXXX                 +     |                   oo               |
        |            oXXoo    XXoo              | 1.5 +X=predictes ooXXXXXXX               + 1.5
        |          oXXo    o  ooXX              |     |o=observed  XXXoo   XXoo            |
        |         oXX        o   XX o           |     |          oXXo   o  ooXX            |
        |        oXXoo        o   XX o          |     |        ooXX       o   XX o         |
        |      o  X             o  XX           |     |        oXXoo        o  XX o        |
    1.0 +        X                 oXX          +     |      o XX            o  XX         |
        |       Xo                   Xo         | 1.0 +       XX                oXX        + 1.0
        |     oXXo                    X         |     |      oXo                  Xo       |
        |    o X                     oXX        |     |     oXo                    X       |
        |     X                        X        |     |    oXX                    oXX      |
        |    XX                        oXo      |     |     X                       X      |
    0.5 +   oX                          Xo      +     |    XX                       Xoo    |
        |   XX                          oX      | 0.5 +   oX                         X     + 0.5
        |   X                       Mean Xo     |     |   XX                        oXX    |
        |  XX  Source        DF   Square oX     |     |   X                           Xo   |
        |  X                              X     |     |  XX  A =  1.0000000           XX   |
        | XX   Model          2  60.6627   X    |     |  X   B = -0.9682499            X   |
    0.0 + o    Error         97   0.0122  oo    +     | XX                             XX  |
        |      Uncorrected   99                 | 0.0 + o                              oo  + 0.0
        |                                       |     |                                    |
        --+--------+--------+--------+--------+--     --+-------+-------+-------+-------+---
        0.00     0.27     0.54     0.81     1.08      0.00    0.25    0.50    0.75    1.00

                            X                                               X

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
