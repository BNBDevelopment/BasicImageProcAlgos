


%in = 3;
%out = my_func(in)
%
%function resulta = my_func(x)
%    resulta = x * 2;
%end

myimg = readraw("resources/data/images/House.raw", 288, 420, true);

reds = zeros(size(myimg,1),size(myimg,2));
greens = zeros(size(myimg,1),size(myimg,2));
blues = zeros(size(myimg,1),size(myimg,2));

disp('TESTING');
size(myimg,2)
disp('TESTING');

pad = 1;
firstrow = myimg(pad,:);
lastrow = myimg(size(myimg,pad),:);
padimg = cat(pad,firstrow, myimg, lastrow);
firstcol = padimg(:,pad);
lastcol = padimg(:,size(padimg,2));
padimg = cat(2,firstcol, padimg, lastcol);

for row = 1:size(myimg,1)
    for col = 1:size(myimg,2)

        %index by 1
        if row == 1 || row == size(padimg,1)
            disp(['first_row']);
        elseif col == 1 || col == size(padimg,2)
            disp(['first_col']);
        else
            if (mod(row,2) == 0 && mod(col,2) == 0) || (mod(row,2) == 1 && mod(col,2) == 1)%GREEN
                greens(row,col) = padimg(row,col);
                reds(row,col) = (0.5 * padimg(row,col-1)) + (0.5 * padimg(row,col+1));
                blues(row,col) = (0.5 * padimg(row-1,col)) + (0.5 * padimg(row+1,col));

            elseif mod(row,2) == 0 && mod(col,2) == 1 %RED
                greens(row,col) = (0.25 * padimg(row-1,col)) + (0.25 * padimg(row+1,col)) + (0.25 * padimg(row,col-1)) + (0.25 * padimg(row,col+1));
                reds(row,col) = padimg(row,col);
                blues(row,col) = (0.25 * padimg(row-1,col+1)) + (0.25 * padimg(row-1,col-1)) + (0.25 * padimg(row+1,col+1)) + (0.25 * padimg(row+1,col-1));

            elseif mod(row,2) == 1 && mod(col,2) == 0 %BLUE
                greens(row,col) = (0.25 * padimg(row-1,col)) + (0.25 * padimg(row+1,col)) + (0.25 * padimg(row,col-1)) + (0.25 * padimg(row,col+1));
                blues(row,col) = padimg(row,col);
                reds(row,col) = (0.25 * padimg(row-1,col+1)) + (0.25 * padimg(row-1,col-1)) + (0.25 * padimg(row+1,col+1)) + (0.25 * padimg(row+1,col-1));
            else
                disp(['ERR ']);
            end
        end
    end
end
disp(['END ']);

colorimg = cat(3, reds, greens, blues)
writtenmyimg = writeraw(colorimg, "testimage.png", false);
