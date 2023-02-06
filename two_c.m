myimg = readraw("resources/data/images/Pepper_gray_noisy.raw", 240, 400, true);



%padded = pad_img(myimg);

%per instructions use open source
nlm_img = imnlmfilt(myimg, ...
    'SearchWindowSize',23, ...
    'ComparisonWindowSize',3, ...
    'DegreeOfSmoothing',9);

writtenmyimg = writeraw(nlm_img, "nlm_dn_gray_pepper.png", true);
imshow(nlm_img/255)

