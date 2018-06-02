function main
clear
clc
cont = true

while cont
try
   disp('Menu')
   disp('1. Input Kriteria')
   disp('2. Show Kriteria')
   disp('3. Input Weight(AHP)')
   disp('4. Input Weight')
   disp('5. Show Weight')
   disp('6. Input Matrix(AHP)')
   disp('7. Input Matrix')
   disp('8. Show Matrix')
   disp('9. Proses')
   disp('10. Keluar')
   menu = input('Input Menu Pilihan = ')
   
   switch menu
       %--------------------------------------------------------------
       case 1
           clear
           cont = true
           n_kriteria = input('Jumlah Kriteria = ')
           s_kriteria = input('Cost/Benefit(0/1) = ')
           sz = size(s_kriteria)
           check = false
           for i=1:sz(2)
               if s_kriteria(1,i) == 1 || s_kriteria(1,i) == 0
                   check = true
               else
                   check = false
               end
           end
           while sz(2) ~= n_kriteria || check == false  
               if sz(2) ~= n_kriteria
                   disp('Error:Jumlah Kriteria tidak sesuai')
                   n_kriteria = input('Jumlah Kriteria = ')
               end
               if check == false
                   disp('Error:Input tidak boleh selain 0 dan 1')
               end
               s_kriteria = input('Cost/Benefit(0/1) = ')
               sz = size(s_kriteria)
               for i=1:sz(2)
                   if s_kriteria(i) == 1 || s_kriteria(i) == 0
                       check = true
                   else
                       check = false
                   end
               end
           end
       %--------------------------------------------------------------    
       case 2
           if exist('n_kriteria')
               s_kriteria               
           else
               disp('Error:Kriteria belum diinputkan')
           end
       %--------------------------------------------------------------
       case 3
           if exist('n_kriteria')
               kk = input(sprintf('Input Matriks Kriteria-Kriteria[%d %d] = ',n_kriteria,n_kriteria))
               sz = size(kk)
               while sz(1)~=sz(2) || sz(1)~=n_kriteria
                   if sz(1)~=sz(2)
                       disp('Error: Harus Matriks Persegi')
                   end
                   if sz(1)~=n_kriteria
                       disp('Error: Ukuran Matriks Tidak Sesuai')
                   end
                   kk = input(sprintf('Input Matriks Kriteria-Kriteria[%d %d] = ',n_kriteria,n_kriteria))
                   sz = size(kk)
               end
               W = translate(kk)
           else
               disp('Error:Kriteria belum diinputkan')
           end
       %--------------------------------------------------------------
       case 4
           if exist('n_kriteria')
               W = input(sprintf('Input Matriks Weight[1 %d] = ',n_kriteria))
               sz = size(W)
               while sz(2) ~= n_kriteria
                   disp('Error: Ukuran Matriks Tidak Sesuai')
                   W = input(sprintf('Input Matriks Weight[1 %d]',n_kriteria))
                   sz = size(W)
               end
               W = transpose(W)
               clear kk
           else
               disp('Error:Kriteria belum diinputkan')
           end
       %--------------------------------------------------------------
       case 5
           if exist('W')
               W
           else
               disp('Error: Weight Belum Ada')
           end
       %--------------------------------------------------------------
       case 6
           if exist('n_kriteria')
               n_alternatif = input('Input Jumlah Alternatif = ')
               for i=1:n_kriteria
                   data = input(sprintf('Input Matrik Alternatif-Kriteria(%d)[%d %d] = ',i,n_alternatif,n_alternatif))
                   sz = size(data)
                   while sz(1)~=sz(2) || sz(1)~=n_alternatif
                       if sz(1)~=sz(2)
                           disp('Error: Harus Matriks Persegi')
                       end
                       if sz(1)~=n_alternatif
                           disp('Error: Ukuran Matriks Tidak Sesuai')
                       end
                       data = input(sprintf('Input Matrik Alternatif-Kriteria$d[%d %d] = ',i,n_alternatif,n_alternatif))
                       sz = size(data)
                   end
                   matrix(:,i) = translate(data)
               end
           else
               disp('Error: Kriteria belum diinputkan')
           end
       %--------------------------------------------------------------
       case 7
           if exist('n_kriteria')
               n_alternatif = input('Input Jumlah Alternatif = ')
               for i=1:n_alternatif
                   matrix(i,:) = input(sprintf('Input Baris-%d = ',i))
                   sz = size(matrix(i,:))
                   while sz(2)~=n_kriteria
                       disp('Error: Jumlah Kriteria Tidak Sesuai')
                       matrix(i) = input(sprintf('Input Baris-%d = ',i))
                       sz = matrix(i,:)                       
                   end
               end
           end
       %--------------------------------------------------------------
       case 8
           if exist('matrix')
               matrix
           else
               disp('Error: Matrix Belum Diinputkan')
           end
       %--------------------------------------------------------------
       case 9
           if exist('n_kriteria') && exist('n_alternatif')
               if exist('kk')
                   disp('---------------------------------------------------')
                   disp('AHP')
                   V_AHP = AHP(matrix, W)
                   CI = consist(kk, W)                   
               else
                   disp('---------------------------------------------------')
                   disp('Tidak Bisa Menggunakan AHP')
               end
               V_SAW = SAW(matrix, W, s_kriteria)
               V_WP = WP(matrix, W, s_kriteria)
               V_TOPSIS = TOPSIS(matrix, W, s_kriteria)
               
               if exist('kk')
                   V_AHP
                   CI
               end
               V_SAW
               V_WP
               V_TOPSIS
           else
               disp('Data Belum Lengkap')
           end
       %--------------------------------------------------------------
       case 10
           cont = false
       otherwise
           disp('Error:Menu Tidak Ditemukan')
   end    
catch
    switch menu
        case 1
            clear
        case 3
            clear kk
            clear W
        case 4
            clear W
        case 6
            clear n_alternatif
            clear matrix
        case 7
            clear n_alternatif
            clear matrix
    end
    
end
   
end
disp('Program Dihentikan')
end

function out = translate(in)
    sz = size(in)
    if sz(1)==sz(2)
        col = sum(in)
        for i=1:sz(2)
            in(:,i)=in(:, i)/col(i)
        end
        out = sum(in,2)/sz(1)
    else
        disp('Error: Harus Matriks Persegi')
    end
end

function out = AHP(matrix, W)
    out = matrix*W
end

function out = consist(kk, W)
    data = kk*W
    sz = size(data)
    for i=1:sz(1)
        data(i) = data(i)/W(i)
    end
    CI = (mean(data)-sz(1))/(sz(1)-1)
    switch sz(1)
        case 2
            out = CI/0
        case 3
            out = CI/0.58
        case 4
            out = CI/0.90
        case 5
            out = CI/1.12
        case 6
            out = CI/1.24
        case 7
            out = CI/1.32
        case 8
            out = CI/1.41            
        case 9
            out = CI/1.45            
        otherwise
            out = CI/1.51
    end
end

function out = SAW(matrix, W, s_kriteria)
sz = size(matrix)
for i=1:sz(2)
    if(s_kriteria(i)==1)
        temp(:,i) = matrix(:,i)/max(matrix(:,i))
    else
        for j=1:sz(1)
           temp(j,i) = min(matrix(:,i))/matrix(j,i)
        end        
    end
end
out = temp*W
end

function out = WP(matrix, W, s_kriteria)
    W2 = W/sum(W)
    sz = size(matrix)
    for i=1:sz(1)
       temp = 1
       for j=1:sz(2)
           if s_kriteria(j)==1
               pow = W2(j)
           else
               pow = -W2(j)
           end
           temp = temp * matrix(i,j)^pow
       end
       S(i) = temp
    end
    out = transpose(S/sum(S))
end

function out = TOPSIS(matrix, W, s_kriteria)
    sz = size(matrix)
    for i=1:sz(2)
        R(:,i) = matrix(:,i)/norm(matrix(:,i))
        Y(:,i) = R(:,i)*W(i)
        if s_kriteria(i)==1
            Ymax(i) = max(Y(:,i))
            Ymin(i) = min(Y(:,i))
        else
            Ymax(i) = min(Y(:,i))
            Ymin(i) = max(Y(:,i))
        end
    end
    Amax = Ymax
    Amin = Ymin
    for i=1:sz(1)
        Dmax(i) = norm(Amax(i) - matrix(i,:))
        Dmin(i) = norm(matrix(i,:) - Amin(i))
        V(i) = Dmin(i)/(Dmin(i)+Dmax(i))
    end
    out = transpose(V)
end