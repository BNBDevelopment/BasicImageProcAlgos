function padimg = padimg_fn(myimg)
    pad = 1;
    firstrow = myimg(1:pad,:);
    lastrow = myimg(size(myimg,1)-pad+1:size(myimg,1),:);
    padimg = cat(1,firstrow, myimg, lastrow);
    firstcol = padimg(:,1:pad);
    lastcol = padimg(:,size(padimg,2)-pad+1:size(padimg,2));
    padimg = cat(2,firstcol, padimg, lastcol);
end