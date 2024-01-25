% ----------------TRABAJO FINAL SISTEMAS DE CONTROL------------------------
% -------------------@Luciano_Ariel_Rodriguez------------------------------
%--------------------------FCEFyN | UNC------------------------------------


% Defino a "s" como variable para trabajar en el dominio de Laplace

s=tf('s');


% Funciones de Transferencia de los bloques que conforman el sistema.


%                       Motor Corriente Continua 
motorCC = (106.47)/(0.25*s+1);


%                               Tierra
tierra= (7.5e-4)/(170.1*s+1);


%                           Pasaje a humedad
pasajeAHumedad=1333.33;


%                               Sensor
sensor = (5)/(((1.3e-6)*s+1))




%                   Funcion de transferencia a lazo abierto


Gs =  motorCC * tierra * pasajeAHumedad;
Hs = sensor  ;
FdTLA = (Gs*Hs)
pole(FdTLA)
figure(1)
rlocus(FdTLA);sgrid



%                   Funcion de transferencia a lazo cerrado


FdTLC = minreal(feedback(Gs,Hs))
zpk(FdTLC)
PolosFdTLC = pole(FdTLC)
figure(2)
pzmap(FdTLC);sgrid
figure(3)
step(FdTLC);grid




%                           Compensacion


compensador = (0.32*(s+0.005879))/s;
LazoAbiertoCompensado = compensador * Gs* Hs;
LazoCerradoCompensado = minreal(feedback(Gs*compensador,Hs));
figure(4)
rlocus(LazoAbiertoCompensado);sgrid


ArregloTau=(27.15*(s+8.7)^4)/((s+14.89)^4) %arreglo del tiempo de establec.
LazoAbiertoFinal = ArregloTau * compensador * Gs*Hs
LazoCerradoFinal=minreal(feedback(ArregloTau*compensador*Gs,Hs))

figure(5)
rlocus(LazoAbiertoFinal);sgrid
figure(6)
hold on
step(FdTLC);grid
step(LazoCerradoFinal);grid
hold off

%                       Respuesta en frecuencia 
figure(7)
hold on
bode(FdTLA);grid
bode(LazoAbiertoFinal);grid
hold off

figure(8)
hold on
bode(FdTLC);grid
bode(LazoCerradoFinal);grid
hold off


