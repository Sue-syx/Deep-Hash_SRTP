%  function creat_GIST��image_path, imgfeature_path)
%  ��������;��ȡͼ���GIS������������
%  image_path����ȡ��ͼƬ��·��
%  imgfeature_path����������·��
%

function creat_GIST(image_path, imgfeature_path)
Images= dir([image_path '\*.jpg']);  %��ȡͼƬ��
Nimage=length(Images);  %��ȡͼƬ����ͼƬ����

% GIST Parameters:
clear param
param.imageSize = [256 256];
param.orientationsPerScale = [8 8 8 8]; % number of orientations per scale (from HF to LF)
param.numberBlocks = 4;
param.fc_prefilt = 4;

Nfeatures = sum(param.orientationsPerScale) * param.numberBlocks ^ 2; 
GIST=zeros([Nimage Nfeatures]);
setwaitbar=waitbar(0,'׼����ʼ','name','������...');

%���ص�һ��ͼ�񲢼���Ҫ�㣺
img = imread([[image_path '\'] Images(1).name]); 
[GIST(1,:),param] = LMgist(img,'',param);   %first call 

for i1=2:Nimage     
    image=imread([[image_path '\'] Images(i1).name]);
    GIST(i1,:) = LMgist(image, '', param);
    
    jinduzhi=fix(i1/Nimage*100);
    waitbar(jinduzhi/100,setwaitbar,['�����' num2str(jinduzhi) '%']);
    
end

save([imgfeature_path '\GIST'], 'GIST');
delete(setwaitbar);
clear setwaitbar;






