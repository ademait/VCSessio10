function [outputArg1] = fulles(inputArg1)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

bw = im2bw(inputArg1,0.6);
bw = ~bw;
ee = strel('disk',5);
bw = imclose(bw,ee);

ero=imerode(bw,strel('disk',1));
cont=xor(ero,bw);

% obtenim les coordenades del contorn
[fila col] = find(bw,1); % Busquem el primer píxel
B = bwtraceboundary(bw,[fila col],'E'); %direccio est a l'atzar
% B conté les coordenades
% Ho comprovem mostrant el resultat
aux=zeros(size(bw));
aux(sub2ind(size(aux),B(:,1),B(:,2)))=1;

% centrem coordenades
mig=mean(B);
B(:,1)=B(:,1)-mig(1);
B(:,2)=B(:,2)-mig(2);
% Convertim les coordenades a complexes
s= B(:,1) + i*B(:,2);
% Cal que la dimensio del vector sigui parell
[mida bobo]=size(B);
if(mida/2~=round(mida/2))
 s(end+1,:)=s(end,:); %dupliquem l'ultim
 mida=mida+1;
end
% Calculem la Fast Fourier Transform
z=fft(s);

outputArg1 = z;
end

