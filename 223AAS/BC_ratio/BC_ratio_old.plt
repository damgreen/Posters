set log x
#set log y
set xlabel "Kinetic Energy (GeV/amu)" font "Helvetica,12"
set ylabel "B/C" font "Helvetica,12"

set xrange[1:200]

a0 = 0.3
a1 = 0.3
a2 = 0.3
b0 = 0.3
b1 = 0.6
b2 = 0.8
c0 = 10
c1 = 10
c2 = 10
f(x) = a0*(x**(-b0))/(1+x**(-b0)/c0)
g(x) = a1*(x**(-b1))/(1+x**(-b1)/c1)
h(x) = a2*(x**(-b2))/(1+x**(-b2)/c2)

fit f(x) 'data.txt' using 3:4 via a0,c0
fit g(x) 'data.txt' using 3:4 via a1,c1
fit h(x) 'data.txt' using 3:4 via a2,c2

step1(x) = x<20 ? a1*(x**(-b1))/(1+x**(-b1)/c1):1/0
step2(x) = x>=20 ? a2*(x**(-b2))/(1+x**(-b2)/c2):1/0
step0(x) = x>=20 ? a0*(x**(-b0))/(1+x**(-b0)/c0):1/0

set xrange[0.5:10000]
#set logscale y

set style fill pattern 5

plot '+' using 1:(step0($1)):(step2($1)) notitle  with filledcurve, \
   "HEAO.txt" using 3:4:($4-($5*$5+$6*$6)**.5):($4+($5*$5+$6*$6)**.5) title 'HEAO-3 C2' with yerrorbars, \
   "AMS-01.txt" using 3:4:($4-($5*$5+$6*$6)**.5):($4+($5*$5+$6*$6)**.5) title 'AMS-01' with yerrorbars, \
   "ATIC.txt" using 3:4:($4-($5*$5+$6*$6)**.5):($4+($5*$5+$6*$6)**.5) title 'ATIC' with yerrorbars pt 1, \
   "CREAM.txt" using 3:4:($4-($5*$5+$6*$6)**.5):($4+($5*$5+$6*$6)**.5) title 'CREAM' with yerrorbars, \
   "tracer.txt" using 3:4:($4-($5*$5+$6*$6)**.5):($4+($5*$5+$6*$6)**.5) title 'TRACER' with yerrorbars lt 8, \
   g(x) title 'R = E^{-0.6}' lt 1
