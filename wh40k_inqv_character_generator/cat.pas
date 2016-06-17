//������ ������� ������� "����������"
//����������� ���������� �.�.

unit cat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, gtl;

type

//<-------------------------------------------------------------------------->\\
//<------------------------------- ������ ----------------------------------->\\
//<-------------------------------------------------------------------------->\\

//������������ ����� ������� ��������
  TGameObject = class
    id: Integer; //������������� �������
  end;

//<-------------------------------------------------------------------------->\\

//����� ��������� ������
  TStorage = class (TGameObject)
     data: TStorageData;
     procedure initialize;
     function SaveContent: TStorageData;
     procedure LoadContent (cont: TStorageData);
  end;

//<-------------------------------------------------------------------------->\\

//����� �������
  THuman = class(TGameObject)
    props: THumanData;
    constructor create (Stock: TStorage); overload;
    constructor create (data: THumanData); overload;
    destructor destroy; overload;
  end;

//<-------------------------------------------------------------------------->\\

//���������� �� 27.07.2015 - ����� ���� (������� ������), ����� ������
//����� ����
  THouse = class(TGameObject)
    people: array [0..9] of integer; //������ ������� ����
    //to-do: ������� ��������� ������ (�����, ���)
    constructor create; overload;
    destructor destroy; overload;
    //to-do: ���������� ������� � ������ �������
  end;

//<-------------------------------------------------------------------------->\\

//����� ������
  TCity = class(TGameObject)
    houselist: array of THouse; //������ ����� - ����� ������ ������������ ������������ ���������
    constructor create (populace: integer); overload;
    destructor destroy; overload;
    procedure settle (populace: integer); //��������� ���������� ������� �� �����
    function is_settled (numb: integer): integer; //����� ������ � ������ (���������� -1 ���� ��� ����� �� �����, � ��������� ������ - ����� ����)
    //to-do: ��������� ��������� ������ ������ �� ������
  end;

//<-------------------------------------------------------------------------->\\  

//����� ������� (����� ������ ���� ������ �������, ����, ������� ����� � �.�.
  TPlanet = class (TGameObject)
    kind: Byte; //������������� ���� ������� (��������� 01.02.2015)
    housing: TCIty; //����� (��������� 19.08.2015)
    people: array [0..DISTRICT_SIZE] of THuman; //������ �������
    factions: array [0..FACTIONS_COUNT] of Integer; //����������� ������� � �������
    time: array [0..2] of Word; //������ ��������� ������ (���, �����, ����)
    store: TStorage; //����-���������
    name: array [0..1] of TNameString; //�������� �������
    constructor create; overload;
    procedure connect; //��������� ���� ��������� (��������� 05.02.2015)
    procedure GetData; //���� ���������� �� �������
  end;

//<-------------------------------------------------------------------------->\\

//<-------------------------------------------------------------------------->\\
//<---------------------------- ������������ -------------------------------->\\
//<-------------------------------------------------------------------------->\\

  function is_between (dig,ubd,lbd: integer): Boolean; //������� �������� ��������� ����� � ������������ ��������
  procedure log_create (fname: string); //��������� �������� ����� ���� � �������� ��� ��� ������
  procedure log_add (fname,msg: string); //��������� ���������� ����� ������ � ��� ������ ��������� (��� ������ � ������������� ��)
  function genrnd (seed,range: Integer): Integer; //������� ��������� ���������� ����� � ��������� seed � ��������� +/- range

implementation

//<-------------------------------------------------------------------------->\\
//<---------------------------- ������������ -------------------------------->\\
//<-------------------------------------------------------------------------->\\

//������� ��������, ��������� �� dig ����� lbd � ubd (��������������� � ����������� lbd <= dig <= ubd)
  function is_between (dig,ubd,lbd: integer): Boolean;
  var
    buf: Integer;
  begin
  //���� �� ������ ������� ������ ������� ���, ��� ������� ������� ������ ������, ������ �� �������
    if (ubd<lbd) then
    begin
      buf:= ubd;
      ubd:= lbd;
      lbd:= buf;
    end;
    if ((dig >= lbd)and(dig <= ubd)) then
      Result:= True
    else
      result:= False;
  end;

//��������� �������� ����� ���� ������ ���������
  procedure log_create (fname: string);
  var
    f: Text;
  begin

  end;

//��������� ������ ������ � ��� ������ ���������
  procedure log_add(fname,msg: string);
  var
    f: Text;
  begin
  //���� ������������ ���� ����  �� ��� ������, ������� ��� � ��������� ���� ���������
    if not(FileExists(fname)) then
    begin

    end
  //���� ��� ��� ����, ������ ���������� ���� ���������
    else
    begin

    end;
  end;

//��������� ���������� ����� �� ������� ��������� seed � ���������� +/-range
  function genrnd (seed,range: Integer): Integer;
  begin
    Randomize;
    Result:= seed + (Random(range*2)-range);
  end;

//<-------------------------------------------------------------------------->\\
//<-------------------------------------------------------------------------->\\

//<-------------------------------------------------------------------------->\\
//<--------------------------- ������ ������� ------------------------------->\\
//<-------------------------------------------------------------------------->\\

//<-------------------------------------------------------------------------->\\
//<---------------������� ����� ������� �������� (TGameObject)--------------->\\
//<-------------------------------------------------------------------------->\\

//<-------------------------------------------------------------------------->\\
//<-------------------------------------------------------------------------->\\

//<-------------------------------------------------------------------------->\\
//<-----------------------����� ����-��������� (TStorage)-------------------->\\
//<-------------------------------------------------------------------------->\\

//
  function TStorage.SaveContent: TStorageData;
  begin
    result:= Self.data;
  end;

//
  procedure TStorage.LoadContent(cont: TStorageData);
  begin
    Self.data:= cont;
  end;

//������������� ����-���������
  procedure TStorage.initialize;
  var
    i: Byte;
    rn1: Integer;
  begin
    //������������� �������� �����
    Self.data.gender[0]:= '�������';
    Self.data.gender[1]:= '�������';
    Self.data.gender[2]:= '�������� / �� ����������';

    //������������� ����� ������ �����
    Self.data.hwtype[0]:= '����� ���';
    Self.data.hwtype[1]:= '���-����';
    Self.data.hwtype[2]:= '��������� ���';
    Self.data.hwtype[3]:= '��������� � �������';

    //��������� �������� �������� ����

    //������������
    //����� ���
    Self.data.bodytype[0,0]:= '��������';
    Self.data.bodytype[0,1]:= '�����';
    Self.data.bodytype[0,2]:= '�����������';
    Self.data.bodytype[0,3]:= '����������';
    Self.data.bodytype[0,4]:= '�����������';
    //���-����
    Self.data.bodytype[1,0]:= '���������';
    Self.data.bodytype[1,1]:= '���������';
    Self.data.bodytype[1,2]:= '��������';
    Self.data.bodytype[1,3]:= '�������';
    Self.data.bodytype[1,4]:= '�������';
    //��������� ���
    Self.data.bodytype[2,0]:= '���������';
    Self.data.bodytype[2,1]:= '��������';
    Self.data.bodytype[2,2]:= '����������';
    Self.data.bodytype[2,3]:= '�������';
    Self.data.bodytype[2,4]:= '���������';
    //��������� � �������
    Self.data.bodytype[3,0]:= '������';
    Self.data.bodytype[3,1]:= '������';
    Self.data.bodytype[3,2]:= '���������';
    Self.data.bodytype[3,3]:= '���������';
    Self.data.bodytype[3,4]:= '����������';

    //���� ����
    //����� ���
    Self.data.skins[0,0]:= '������';
    Self.data.skins[0,1]:= '���������';
    Self.data.skins[0,2]:= '�������';
    Self.data.skins[0,3]:= '�������';
    Self.data.skins[0,4]:= '���������';
    //���-����
    Self.data.skins[1,0]:= '������';
    Self.data.skins[1,1]:= '���������';
    Self.data.skins[1,2]:= '�������';
    Self.data.skins[1,3]:= '�������';
    Self.data.skins[1,4]:= '��������';
    //��������� ���
    Self.data.skins[2,0]:= '������';
    Self.data.skins[2,1]:= '���������';
    Self.data.skins[2,2]:= '�������';
    Self.data.skins[2,3]:= '�������';
    Self.data.skins[2,4]:= '��������';
    //��������� � �������
    Self.data.skins[3,0]:= '����������';
    Self.data.skins[3,1]:= '�������';
    Self.data.skins[3,2]:= '�����������';
    Self.data.skins[3,3]:= '���������';
    Self.data.skins[3,4]:= '��������';

    //����� �����
    //����� ���
    Self.data.hairs[0,0]:= '�����';
    Self.data.hairs[0,1]:= '�������';
    Self.data.hairs[0,2]:= '�����';
    Self.data.hairs[0,3]:= '������';
    Self.data.hairs[0,4]:= '�����';
    //���-����
    Self.data.hairs[1,0]:= '�����';
    Self.data.hairs[1,1]:= '�����';
    Self.data.hairs[1,2]:= '��������';
    Self.data.hairs[1,3]:= '�����';
    Self.data.hairs[1,4]:= '������';
    //��������� ���
    Self.data.hairs[2,0]:= '��������';
    Self.data.hairs[2,1]:= '�������';
    Self.data.hairs[2,2]:= '�����';
    Self.data.hairs[2,3]:= '������';
    Self.data.hairs[2,4]:= '�����';
    //��������� � �������
    Self.data.hairs[3,0]:= '���������';
    Self.data.hairs[3,1]:= '�������';
    Self.data.hairs[3,2]:= '������';
    Self.data.hairs[3,3]:= '������';
    Self.data.hairs[3,4]:= '����������';

    //����� ����
    // ����� ���
    Self.data.eyes[0,0]:= '�������';
    Self.data.eyes[0,1]:= '�����';
    Self.data.eyes[0,2]:= '�����';
    Self.data.eyes[0,3]:= '�������';
    Self.data.eyes[0,4]:= '������';
    //���-����
    Self.data.eyes[1,0]:= '�����';
    Self.data.eyes[1,1]:= '�����';
    Self.data.eyes[1,2]:= '�����';
    Self.data.eyes[1,3]:= '�������';
    Self.data.eyes[1,4]:= '�����';
    //��������� ���
    Self.data.eyes[2,0]:= '�������';
    Self.data.eyes[2,1]:= '�����';
    Self.data.eyes[2,2]:= '�����';
    Self.data.eyes[2,3]:= '�������';
    Self.data.eyes[2,4]:= '�����';
    //��������� � �������
    Self.data.eyes[3,0]:= '������-�������';
    Self.data.eyes[3,1]:= '�����';
    Self.data.eyes[3,2]:= '������';
    Self.data.eyes[3,3]:= '�������';
    Self.data.eyes[3,4]:= '����������';

    //��������� ������� ����/���
    //����� ���
    Self.data.heitype[0,0,0][0]:= 190; Self.data.heitype[0,0,0][1]:= 65;
    Self.data.heitype[0,1,0][0]:= 180; Self.data.heitype[0,1,0][1]:= 60;

    Self.data.heitype[0,0,1][0]:= 175; Self.data.heitype[0,0,1][1]:= 60;
    Self.data.heitype[0,1,1][0]:= 165; Self.data.heitype[0,1,1][1]:= 55;

    Self.data.heitype[0,0,2][0]:= 185; Self.data.heitype[0,0,2][1]:= 85;
    Self.data.heitype[0,1,2][0]:= 170; Self.data.heitype[0,1,2][1]:= 70;

    Self.data.heitype[0,0,3][0]:= 165; Self.data.heitype[0,0,3][1]:= 80;
    Self.data.heitype[0,1,3][0]:= 155; Self.data.heitype[0,1,3][1]:= 70;

    Self.data.heitype[0,0,4][0]:= 210; Self.data.heitype[0,0,4][1]:= 200;
    Self.data.heitype[0,1,4][0]:= 120; Self.data.heitype[0,1,4][1]:= 100;
    //���-����
    Self.data.heitype[1,0,0][0]:= 165; Self.data.heitype[1,0,0][1]:= 45;
    Self.data.heitype[1,1,0][0]:= 155; Self.data.heitype[1,1,0][1]:= 40;

    Self.data.heitype[1,0,1][0]:= 170; Self.data.heitype[1,0,1][1]:= 55;
    Self.data.heitype[1,1,1][0]:= 160; Self.data.heitype[1,1,1][1]:= 50;

    Self.data.heitype[1,0,2][0]:= 175; Self.data.heitype[1,0,2][1]:= 65;
    Self.data.heitype[1,1,2][0]:= 165; Self.data.heitype[1,1,2][1]:= 55;

    Self.data.heitype[1,0,3][0]:= 180; Self.data.heitype[1,0,3][1]:= 65;
    Self.data.heitype[1,1,3][0]:= 170; Self.data.heitype[1,1,3][1]:= 60;

    Self.data.heitype[1,0,4][0]:= 175; Self.data.heitype[1,0,4][1]:= 80;
    Self.data.heitype[1,1,4][0]:= 165; Self.data.heitype[1,1,4][1]:= 75;
    //��������� ���
    Self.data.heitype[2,0,0][0]:= 175; Self.data.heitype[2,0,0][1]:= 65;
    Self.data.heitype[2,1,0][0]:= 165; Self.data.heitype[2,1,0][1]:= 60;

    Self.data.heitype[2,0,1][0]:= 185; Self.data.heitype[2,0,1][1]:= 70;
    Self.data.heitype[2,1,1][0]:= 175; Self.data.heitype[2,1,1][1]:= 65;

    Self.data.heitype[2,0,2][0]:= 175; Self.data.heitype[2,0,2][1]:= 70;
    Self.data.heitype[2,1,2][0]:= 165; Self.data.heitype[2,1,2][1]:= 60;

    Self.data.heitype[2,0,3][0]:= 190; Self.data.heitype[2,0,3][1]:= 90;
    Self.data.heitype[2,1,3][0]:= 180; Self.data.heitype[2,1,3][1]:= 80;

    Self.data.heitype[2,0,4][0]:= 180; Self.data.heitype[2,0,4][1]:= 100;
    Self.data.heitype[2,1,4][0]:= 170; Self.data.heitype[2,1,4][1]:= 90;
    //��������� � �������
    Self.data.heitype[3,0,0][0]:= 175; Self.data.heitype[3,0,0][1]:= 55;
    Self.data.heitype[3,1,0][0]:= 170; Self.data.heitype[3,1,0][1]:= 50;

    Self.data.heitype[3,0,1][0]:= 165; Self.data.heitype[3,0,1][1]:= 55;
    Self.data.heitype[3,1,1][0]:= 155; Self.data.heitype[3,1,1][1]:= 45;

    Self.data.heitype[3,0,2][0]:= 185; Self.data.heitype[3,0,2][1]:= 60;
    Self.data.heitype[3,1,2][0]:= 175; Self.data.heitype[3,1,2][1]:= 60;

    Self.data.heitype[3,0,3][0]:= 200; Self.data.heitype[3,0,3][1]:= 80;
    Self.data.heitype[3,1,3][0]:= 185; Self.data.heitype[3,1,3][1]:= 70;

    Self.data.heitype[3,0,4][0]:= 210; Self.data.heitype[3,0,4][1]:= 75;
    Self.data.heitype[3,1,4][0]:= 195; Self.data.heitype[3,1,4][1]:= 70;

    //��������� ������� ������ ������
    Self.data.perks[0,0]:=  '��������� ��������';   Self.data.perks[1,0]:=  '�������';              Self.data.perks[2,0]:=  '����������� �����';    Self.data.perks[3,0]:=  '�������';
    Self.data.perks[0,1]:=  '��������� �����';      Self.data.perks[1,1]:=  '�������';              Self.data.perks[2,1]:=  '������� ���';          Self.data.perks[3,1]:=  '�����';
    Self.data.perks[0,2]:=  '������ ���������';     Self.data.perks[1,2]:=  '����� ��������';       Self.data.perks[2,2]:=  '���������';            Self.data.perks[3,2]:=  '������� ������';
    Self.data.perks[0,3]:=  '������-������';        Self.data.perks[1,3]:=  '������ ����';          Self.data.perks[2,3]:=  '�������� ����';        Self.data.perks[3,3]:=  '��������� ���';
    Self.data.perks[0,4]:=  '������ ����';          Self.data.perks[1,4]:=  '�����������������';    Self.data.perks[2,4]:=  '������� � ����';       Self.data.perks[3,4]:=  '����� ����������';
    Self.data.perks[0,5]:=  '��������� �����';      Self.data.perks[1,5]:=  '�������';              Self.data.perks[2,5]:=  '������� ���';          Self.data.perks[3,5]:=  '������ �����';
    Self.data.perks[0,6]:=  '��������� �����';      Self.data.perks[1,6]:=  '������������ �������'; Self.data.perks[2,6]:=  '���������� � �������'; Self.data.perks[3,6]:=  '������ ����';
    Self.data.perks[0,7]:=  '���������';            Self.data.perks[1,7]:=  '����� ������';         Self.data.perks[2,7]:=  '������� �����';        Self.data.perks[3,7]:=  '������ ������������� �����';
    Self.data.perks[0,8]:=  '������ ���';           Self.data.perks[1,8]:=  '����������';           Self.data.perks[2,8]:=  '������';               Self.data.perks[3,8]:=  '������� ������';
    Self.data.perks[0,9]:=  '������� �����';        Self.data.perks[1,9]:=  '������� ����';         Self.data.perks[2,9]:=  '����������� ����';     Self.data.perks[3,9]:=  '����������� �����������';
    Self.data.perks[0,10]:= '��������� ����������'; Self.data.perks[1,10]:= '������� ���';          Self.data.perks[2,10]:= '�����������������';    Self.data.perks[3,10]:= '����������';
    Self.data.perks[0,11]:= '������������';         Self.data.perks[1,11]:= '������� �����';        Self.data.perks[2,11]:= '����� � �������';      Self.data.perks[3,11]:= '���������� ����';
    Self.data.perks[0,12]:= '�������';              Self.data.perks[1,12]:= '���������� �����';     Self.data.perks[2,12]:= '���������� ���';       Self.data.perks[3,12]:= '��������� ������';
    Self.data.perks[0,13]:= '������� �����';        Self.data.perks[1,13]:= '����';                 Self.data.perks[2,13]:= '������ �����';         Self.data.perks[3,13]:= '��������';
    Self.data.perks[0,14]:= '��������� ������';     Self.data.perks[1,14]:= '��������� ����';       Self.data.perks[2,14]:= '������';               Self.data.perks[3,14]:= '������ �������';
    Self.data.perks[0,15]:= '��������� �������';    Self.data.perks[1,15]:= '���������� �����';     Self.data.perks[2,15]:= '��������� �������';    Self.data.perks[3,15]:= '�������';

    //������������� ������ ������� ����
    with Self.data.mnames do
    begin
      prim[0]:=  '���';    low[0]:= '�����';     high[0]:=  '�������';   arch[0]:=  '������';     infr[0]:=  '����';
      prim[1]:=  '�����';  low[1]:= '����';      high[1]:=  '������';    arch[1]:=  '������';     infr[1]:=  '�����';
      prim[2]:=  '���';    low[2]:= '�������';   high[2]:=  '��������';  arch[2]:=  '�������';    infr[2]:=  '������';
      prim[3]:=  '����';   low[3]:= '����';      high[3]:=  '������';    arch[3]:=  '������';     infr[3]:=  '������';
      prim[4]:=  '����';   low[4]:= '����';      high[4]:=  '�������';   arch[4]:=  '����������'; infr[4]:=  '�����';
      prim[5]:=  '����';   low[5]:= '�����';     high[5]:=  '�������';   arch[5]:=  '��������';   infr[5]:=  '�����';
      prim[6]:=  '����';   low[6]:= '���';       high[6]:=  '������';    arch[6]:=  '����';       infr[6]:=  '����';
      prim[7]:=  '����';   low[7]:= '�������';   high[7]:=  '�������';   arch[7]:=  '�����';      infr[7]:=  '�����';
      prim[8]:=  '���';    low[8]:= '����';      high[8]:=  '������';    arch[8]:=  '�����';      infr[8]:=  '�������';
      prim[9]:=  '�����';  low[9]:= '�����';     high[9]:=  '���������'; arch[9]:=  '������';     infr[9]:=  '����';
      prim[10]:= '���';    low[10]:= '�������';  high[10]:= '�������';   arch[10]:= '��������';   infr[10]:= '���';
      prim[11]:= '�����';  low[11]:= '�������';  high[11]:= '�������';   arch[11]:= '��������';   infr[11]:= '�������';
      prim[12]:= '�����';  low[12]:= '�����';    high[12]:= '�����';     arch[12]:= '������';     infr[12]:= '�����';
      prim[13]:= '���';    low[13]:= '������';   high[13]:= '�������';   arch[13]:= '������';     infr[13]:= '������';
      prim[14]:= '���';    low[14]:= '��������'; high[14]:= '�������';   arch[14]:= '��������';   infr[14]:= '����';
      prim[15]:= '���';    low[15]:= '�����';    high[15]:= '�������';   arch[15]:= '���';        infr[15]:= '���';
      prim[16]:= '����';   low[16]:= '�������';  high[16]:= '�����';     arch[16]:= '�����';      infr[16]:= '��������';
      prim[17]:= '���';    low[17]:= '������';   high[17]:= '�����';     arch[17]:= '���';        infr[17]:= '�����';
      prim[18]:= '�����';  low[18]:= '�����';    high[18]:= '������';    arch[18]:= '������';     infr[18]:= '�������';
      prim[19]:= '�����';  low[19]:= '�������';  high[19]:= '�������';   arch[19]:= '��������';   infr[19]:= '�����';
      prim[20]:= '���';    low[20]:= '������';   high[20]:= '�������';   arch[20]:= '�������';    infr[20]:= '�����';
      prim[21]:= '����';   low[21]:= '�������';  high[21]:= '������';    arch[21]:= '�������';    infr[21]:= '����';
      prim[22]:= '����';   low[22]:= '�������';  high[22]:= '�����';     arch[22]:= '������';     infr[22]:= '�������';
      prim[23]:= '������'; low[23]:= '������';   high[23]:= '�������';   arch[23]:= '���������';  infr[23]:= '�����';
      prim[24]:= '���';    low[24]:= '���';      high[24]:= '�����';     arch[24]:= '�������';    infr[24]:= '����';
      prim[25]:= '����';   low[25]:= '�����';    high[25]:= '������';    arch[25]:= '����';       infr[25]:= '���';
      prim[26]:= '����';   low[26]:= '������';   high[26]:= '�������';   arch[26]:= '�����';      infr[26]:= '���';
      prim[27]:= '�����';  low[27]:= '������';   high[27]:= '������';    arch[27]:= '�����';      infr[27]:= '�����';
      prim[28]:= '���';    low[28]:= '�������';  high[28]:= '������';    arch[28]:= '����';       infr[28]:= '�������';
      prim[29]:= '���';    low[29]:= '�������';  high[29]:= '�������';   arch[29]:= '������';     infr[29]:= '������';
    end;

    //������������� ������ ������� ����
    with Self.data.fnames do
    begin
      prim[0]:=  '����';    low[0]:=  '������';    high[0]:=  '������';    arch[0]:=  '����';       infr[0]:=  '�����';
      prim[1]:=  '������';  low[1]:=  '�������';   high[1]:=  '��������';  arch[1]:=  '������';     infr[1]:=  '�������';
      prim[2]:=  '�����';   low[2]:=  '������';    high[2]:=  '��������';  arch[2]:=  '�������';    infr[2]:=  '�����';
      prim[3]:=  '�����';   low[3]:=  '�����';     high[3]:=  '��������';  arch[3]:=  '�������';    infr[3]:=  '�����';
      prim[4]:=  '�����';   low[4]:=  '�������';   high[4]:=  '��������';  arch[4]:=  '����';       infr[4]:=  '��������';
      prim[5]:=  '�����';   low[5]:=  '�����';     high[5]:=  '������';    arch[5]:=  '����';       infr[5]:=  '����';
      prim[6]:=  '�����';   low[6]:=  '�������';   high[6]:=  '������';    arch[6]:=  '������';     infr[6]:=  '����';
      prim[7]:=  '�����';   low[7]:=  '������';    high[7]:=  '������';    arch[7]:=  '����';       infr[7]:=  '�����';
      prim[8]:=  '����';    low[8]:=  '����';      high[8]:=  '������';    arch[8]:=  '����������'; infr[8]:=  '������';
      prim[9]:=  '������';  low[9]:=  '�������';   high[9]:=  '���������'; arch[9]:=  '�������';    infr[9]:=  '�������';
      prim[10]:= '�����';   low[10]:= '�������';   high[10]:= '������';    arch[10]:= '��������';   infr[10]:= '���';
      prim[11]:= '������';  low[11]:= '���';       high[11]:= '�������';   arch[11]:= '�����';      infr[11]:= '����';
      prim[12]:= '������';  low[12]:= '����';      high[12]:= '����';      arch[12]:= '�����';      infr[12]:= '����';
      prim[13]:= '�����';   low[13]:= '������';    high[13]:= '������';    arch[13]:= '����';       infr[13]:= '�����';
      prim[14]:= '�����';   low[14]:= '������';    high[14]:= '����';      arch[14]:= '����';       infr[14]:= '����������';
      prim[15]:= '����';    low[15]:= '����';      high[15]:= '�������';   arch[15]:= '���';        infr[15]:= '����';
      prim[16]:= '�����';   low[16]:= '���������'; high[16]:= '�����';     arch[16]:= '���������';  infr[16]:= '�������';
      prim[17]:= '����';    low[17]:= '������';    high[17]:= '�����';     arch[17]:= '������';     infr[17]:= '�����';
      prim[18]:= '�����';   low[18]:= '������';    high[18]:= '������';    arch[18]:= '�������';    infr[18]:= '����';
      prim[19]:= '�����';   low[19]:= '�����';     high[19]:= '���������'; arch[19]:= '������';     infr[19]:= '�����';
      prim[20]:= '����';    low[20]:= '������';    high[20]:= '�������';   arch[20]:= '������';     infr[20]:= '�����';
      prim[21]:= '������';  low[21]:= '���';       high[21]:= '�����';     arch[21]:= '������';     infr[21]:= '����';
      prim[22]:= '������';  low[22]:= '�������';   high[22]:= '�����';     arch[22]:= '�����';      infr[22]:= '�������';
      prim[23]:= '�������'; low[23]:= '�������';   high[23]:= '��������';  arch[23]:= '������';     infr[23]:= '���';
      prim[24]:= '�����';   low[24]:= '�������';   high[24]:= '����';      arch[24]:= '������';     infr[24]:= '�����';
      prim[25]:= '�����';   low[25]:= '����';      high[25]:= '�����';     arch[25]:= '�����';      infr[25]:= '�����';
      prim[26]:= '�����';   low[26]:= '������';    high[26]:= '�������';   arch[26]:= '������';     infr[26]:= '������';
      prim[27]:= '������';  low[27]:= '�����';     high[27]:= '������';    arch[27]:= '������';     infr[27]:= '����';
      prim[28]:= '����';    low[28]:= '���������'; high[28]:= '������';    arch[28]:= '���������';  infr[28]:= '������';
      prim[29]:= '�����';   low[29]:= '�������';   high[29]:= '�������';   arch[29]:= '������';     infr[29]:= '��';
    end;

    //���������� �� 01.02.2015

    //�������� �������
    Self.data.cnames[0]:= '�����';    Self.data.cnames[1]:= '������';
    Self.data.cnames[2]:= '������';   Self.data.cnames[3]:= '������';
    Self.data.cnames[4]:= '��������'; Self.data.cnames[5]:= '�������';
    Self.data.cnames[6]:= '�������';  Self.data.cnames[7]:= '���������';

    //�������� ����������
    Self.data.snames[0]:= '������� ���';  Self.data.snames[1]:= '��������';
    Self.data.snames[2]:= '����';         Self.data.snames[3]:= '������������';
    Self.data.snames[4]:= '��������';     Self.data.snames[5]:= '���������';
    Self.data.snames[6]:= '����������';   Self.data.snames[7]:= '���� ����';
    Self.data.snames[8]:= '������������';

    //������ � ���������� �� ������������� ���
    //����� ���
    Self.data.sbonus[0,0]:= 20; Self.data.sbonus[0,1]:= 20;
    Self.data.sbonus[0,2]:= 25; Self.data.sbonus[0,3]:= 25;
    Self.data.sbonus[0,4]:= 20; Self.data.sbonus[0,5]:= 20;
    Self.data.sbonus[0,6]:= 20; Self.data.sbonus[0,7]:= 15;
    Self.data.sbonus[0,8]:= 15;
    //���-����
    Self.data.sbonus[1,0]:= 20; Self.data.sbonus[1,1]:= 20;
    Self.data.sbonus[1,2]:= 20; Self.data.sbonus[1,3]:= 15;
    Self.data.sbonus[1,4]:= 20; Self.data.sbonus[1,5]:= 20;
    Self.data.sbonus[1,6]:= 20; Self.data.sbonus[1,7]:= 20;
    Self.data.sbonus[1,8]:= 25;
    //��������� ���
    Self.data.sbonus[2,0]:= 20; Self.data.sbonus[2,1]:= 20;
    Self.data.sbonus[2,2]:= 20; Self.data.sbonus[2,3]:= 20;
    Self.data.sbonus[2,4]:= 20; Self.data.sbonus[2,5]:= 20;
    Self.data.sbonus[2,6]:= 20; Self.data.sbonus[2,7]:= 20;
    Self.data.sbonus[2,8]:= 20;
    //�������� � �������
    Self.data.sbonus[3,0]:= 20; Self.data.sbonus[3,1]:= 20;
    Self.data.sbonus[3,2]:= 15; Self.data.sbonus[3,3]:= 20;
    Self.data.sbonus[3,4]:= 20; Self.data.sbonus[3,5]:= 20;
    Self.data.sbonus[3,6]:= 20; Self.data.sbonus[3,7]:= 25;
    Self.data.sbonus[3,8]:= 20;

    //����������� �������������� �� �������������
    //����� ���
    Self.data.sprobs[0,0]:= 0;  Self.data.sprobs[0,1]:= 0;  Self.data.sprobs[0,2]:= 30; Self.data.sprobs[0,3]:= 0;
    Self.data.sprobs[0,4]:= 50; Self.data.sprobs[0,5]:= 10; Self.data.sprobs[0,6]:= 10; Self.data.sprobs[0,7]:= 0;
    //���-����
    Self.data.sprobs[1,0]:= 0;  Self.data.sprobs[1,1]:= 17; Self.data.sprobs[1,2]:= 3;  Self.data.sprobs[1,3]:= 5;
    Self.data.sprobs[1,4]:= 10; Self.data.sprobs[1,5]:= 4;  Self.data.sprobs[1,6]:= 50; Self.data.sprobs[1,7]:= 11;
    //��������� ���
    Self.data.sprobs[2,0]:= 12; Self.data.sprobs[2,1]:= 13; Self.data.sprobs[2,2]:= 13; Self.data.sprobs[2,3]:= 14;
    Self.data.sprobs[2,4]:= 13; Self.data.sprobs[2,5]:= 14; Self.data.sprobs[2,6]:= 11; Self.data.sprobs[2,7]:= 10;
    //��������� � �������
    Self.data.sprobs[3,0]:= 10; Self.data.sprobs[3,1]:= 10; Self.data.sprobs[3,2]:= 5;  Self.data.sprobs[3,3]:= 10;
    Self.data.sprobs[3,4]:= 0;  Self.data.sprobs[3,5]:= 40; Self.data.sprobs[3,6]:= 10; Self.data.sprobs[3,7]:= 15;

    //�������� �������
    Self.data.factions[0]:= '���������';     Self.data.factions[1]:= '������';
    Self.data.factions[2]:= '��������';      Self.data.factions[3]:= '��������� �������';
    Self.data.factions[4]:= '�������';       Self.data.factions[5]:= '������������';
    Self.data.factions[6]:= '���������';     Self.data.factions[7]:= '���� ������';
    Self.data.factions[8]:= '���� ��������'; Self.data.factions[9]:= '���� �������';

    //�������� ����������
    Self.data.pnames[0]:= '�������';   Self.data.pnames[1]:= '��������';   Self.data.pnames[2]:= '�������';
    Self.data.pnames[3]:= '�����';     Self.data.pnames[4]:= '����������'; Self.data.pnames[5]:= '������������';
    Self.data.pnames[6]:= '���������'; Self.data.pnames[7]:= '���������';  Self.data.pnames[8]:= '���������';

    //����������� ��������� ���������� ��������
    Self.data.fprobs[0]:= 80; Self.data.fprobs[1]:= 25;
    Self.data.fprobs[2]:= 18; Self.data.fprobs[3]:= 30;
    Self.data.fprobs[4]:= 5;  Self.data.fprobs[5]:= 15;
    Self.data.fprobs[6]:= 10; Self.data.fprobs[7]:= 2;
    Self.data.fprobs[8]:= 2;  Self.data.fprobs[9]:= 2;

    //����������� ��������� ����������� (������)
    Self.data.lprobs[0]:= 67; Self.data.lprobs[1]:= 7;
    Self.data.lprobs[2]:= 23; Self.data.lprobs[3]:= 3;

    //���������� �� 04.02.2015-05.02.2015
    //������ ���������� ����������� ������ (const, ������������ ��� ��������� ������ �� ��������)
    Self.data.grexe:= '.png';

    //���������� �� 29.05.2015
    //������ �������� ���������� ������� ������
    Self.data.plnames[0]:= '������';   Self.data.plnames[1]:= '��������';
    Self.data.plnames[2]:= '�������';  Self.data.plnames[3]:= '������';
    Self.data.plnames[4]:= '������';   Self.data.plnames[5]:= '�������';
    Self.data.plnames[6]:= '��������'; Self.data.plnames[7]:= '�����';
    Self.data.plnames[8]:= '�����';    Self.data.plnames[9]:= '�������';

    //���������� �� 01.07.2015
    //������ ������������� �����������

    //������������ ������
    //����� �����
    Self.data.addmods.clasmods[0][ag_force]:= -20;   Self.data.addmods.clasmods[0][ag_court]:= 15;
    Self.data.addmods.clasmods[0][ag_stealth]:= -15; Self.data.addmods.clasmods[0][ag_investigation]:= 20;
    Self.data.addmods.clasmods[0][ag_others]:= 0;

    //����� ������
    Self.data.addmods.clasmods[1][ag_force]:= 15;    Self.data.addmods.clasmods[1][ag_court]:= -15;
    Self.data.addmods.clasmods[1][ag_stealth]:= -20; Self.data.addmods.clasmods[1][ag_investigation]:= 20;
    Self.data.addmods.clasmods[1][ag_others]:= 0;

    //����� ������
    Self.data.addmods.clasmods[2][ag_force]:= -15;   Self.data.addmods.clasmods[2][ag_court]:= -20;
    Self.data.addmods.clasmods[2][ag_stealth]:= 20;  Self.data.addmods.clasmods[2][ag_investigation]:= 15;
    Self.data.addmods.clasmods[2][ag_others]:= 0;

    //����� ������
    Self.data.addmods.clasmods[3][ag_force]:= -10;   Self.data.addmods.clasmods[3][ag_court]:= 15;
    Self.data.addmods.clasmods[3][ag_stealth]:= -15; Self.data.addmods.clasmods[3][ag_investigation]:= 10;
    Self.data.addmods.clasmods[3][ag_others]:= 0;

    //����� ��������
    Self.data.addmods.clasmods[4][ag_force]:= 20;    Self.data.addmods.clasmods[4][ag_court]:= -20;
    Self.data.addmods.clasmods[4][ag_stealth]:= 15;  Self.data.addmods.clasmods[4][ag_investigation]:= -15;
    Self.data.addmods.clasmods[4][ag_others]:= 0;

    //����� �������
    Self.data.addmods.clasmods[5][ag_force]:= -20;   Self.data.addmods.clasmods[5][ag_court]:= -15;
    Self.data.addmods.clasmods[5][ag_stealth]:= 15;  Self.data.addmods.clasmods[5][ag_investigation]:= 20;
    Self.data.addmods.clasmods[5][ag_others]:= 0;

    //����� �������
    Self.data.addmods.clasmods[6][ag_force]:= 15;    Self.data.addmods.clasmods[6][ag_court]:= -15;
    Self.data.addmods.clasmods[6][ag_stealth]:= 20;  Self.data.addmods.clasmods[6][ag_investigation]:= -20;
    Self.data.addmods.clasmods[6][ag_others]:= 0;

    //����� ���������
    Self.data.addmods.clasmods[7][ag_force]:= 15;    Self.data.addmods.clasmods[7][ag_court]:= -15;
    Self.data.addmods.clasmods[7][ag_stealth]:= -20; Self.data.addmods.clasmods[7][ag_investigation]:= 20;
    Self.data.addmods.clasmods[7][ag_others]:= 0;

    //������������ �������������
    //������������� ����� ���
    Self.data.addmods.origmods[0][ag_force]:= 20;    Self.data.addmods.origmods[0][ag_court]:= -20;
    Self.data.addmods.origmods[0][ag_stealth]:= 10;  Self.data.addmods.origmods[0][ag_investigation]:= -10;
    Self.data.addmods.origmods[0][ag_others]:= 0;

    //������������� ���-����
    Self.data.addmods.origmods[1][ag_force]:= -10;   Self.data.addmods.origmods[1][ag_court]:= 15;
    Self.data.addmods.origmods[1][ag_stealth]:= 15;  Self.data.addmods.origmods[1][ag_investigation]:= 10;
    Self.data.addmods.origmods[1][ag_others]:= 0;

    //������������� ��������� ���
    Self.data.addmods.origmods[2][ag_force]:= 10;    Self.data.addmods.origmods[2][ag_court]:= 20;
    Self.data.addmods.origmods[2][ag_stealth]:= -20; Self.data.addmods.origmods[2][ag_investigation]:= -10;
    Self.data.addmods.origmods[2][ag_others]:= 0;

    //������������� �������
    Self.data.addmods.origmods[3][ag_force]:= -20;   Self.data.addmods.origmods[3][ag_court]:= -10;
    Self.data.addmods.origmods[3][ag_stealth]:= 10;  Self.data.addmods.origmods[3][ag_investigation]:= 20;
    Self.data.addmods.origmods[3][ag_others]:= 0;

    //������������ �������
    //������� ��������
    Self.data.addmods.factmods[0][ag_force]:= -10;   Self.data.addmods.factmods[0][ag_court]:= 10;
    Self.data.addmods.factmods[0][ag_stealth]:= 10;  Self.data.addmods.factmods[0][ag_investigation]:= -10;
    Self.data.addmods.factmods[0][ag_others]:= 0;

    //������� �������
    Self.data.addmods.factmods[1][ag_force]:= 15;    Self.data.addmods.factmods[1][ag_court]:= -15;
    Self.data.addmods.factmods[1][ag_stealth]:= 15;  Self.data.addmods.factmods[1][ag_investigation]:= -15;
    Self.data.addmods.factmods[1][ag_others]:= 0;

    //������� ��������
    Self.data.addmods.factmods[2][ag_force]:= 15;    Self.data.addmods.factmods[2][ag_court]:= -15;
    Self.data.addmods.factmods[2][ag_stealth]:= -20; Self.data.addmods.factmods[2][ag_investigation]:= 20;
    Self.data.addmods.factmods[2][ag_others]:= 0;

    //������� ��������� �������
    Self.data.addmods.factmods[3][ag_force]:= 20;    Self.data.addmods.factmods[3][ag_court]:= -20;
    Self.data.addmods.factmods[3][ag_stealth]:= 10;  Self.data.addmods.factmods[3][ag_investigation]:= -10;
    Self.data.addmods.factmods[3][ag_others]:= 0;

    //������� �������
    Self.data.addmods.factmods[4][ag_force]:= 0;     Self.data.addmods.factmods[4][ag_court]:= 0;
    Self.data.addmods.factmods[4][ag_stealth]:= 0;   Self.data.addmods.factmods[4][ag_investigation]:= 0;
    Self.data.addmods.factmods[4][ag_others]:= 0;

    //������� ������������
    Self.data.addmods.factmods[5][ag_force]:= -10;   Self.data.addmods.factmods[5][ag_court]:= 20;
    Self.data.addmods.factmods[5][ag_stealth]:= -20; Self.data.addmods.factmods[5][ag_investigation]:= 10;
    Self.data.addmods.factmods[5][ag_others]:= 0;

    //������� ���������
    Self.data.addmods.factmods[6][ag_force]:= 15;    Self.data.addmods.factmods[6][ag_court]:= -15;
    Self.data.addmods.factmods[6][ag_stealth]:= -20; Self.data.addmods.factmods[6][ag_investigation]:= 20;
    Self.data.addmods.factmods[6][ag_others]:= 0;

    //������� ���� ������
    Self.data.addmods.factmods[7][ag_force]:= 0;     Self.data.addmods.factmods[7][ag_court]:= 0;
    Self.data.addmods.factmods[7][ag_stealth]:= 0;   Self.data.addmods.factmods[7][ag_investigation]:= 0;
    Self.data.addmods.factmods[7][ag_others]:= 0;

    //������� ���� ��������
    Self.data.addmods.factmods[8][ag_force]:= 0;     Self.data.addmods.factmods[8][ag_court]:= 0;
    Self.data.addmods.factmods[8][ag_stealth]:= 0;   Self.data.addmods.factmods[8][ag_investigation]:= 0;
    Self.data.addmods.factmods[8][ag_others]:= 0;

    //������� ���� �������
    Self.data.addmods.factmods[9][ag_force]:= 0;     Self.data.addmods.factmods[9][ag_court]:= 0;
    Self.data.addmods.factmods[9][ag_stealth]:= 0;   Self.data.addmods.factmods[9][ag_investigation]:= 0;
    Self.data.addmods.factmods[9][ag_others]:= 0;

    //���������� �� 03.07.2015
    //������������ ���������� DMS

    //������������ ������
    //����� �����
    Self.data.dmsmods.clasmods[0][dp_diligence]:= 20; Self.data.dmsmods.clasmods[0][dp_identity]:= 20;
    Self.data.dmsmods.clasmods[0][dp_calmness]:= 0;  Self.data.dmsmods.clasmods[0][dp_educability]:= 20;
    Self.data.dmsmods.clasmods[0][dp_authority]:= 10;

    //����� ������
    Self.data.dmsmods.clasmods[1][dp_diligence]:= 20; Self.data.dmsmods.clasmods[1][dp_identity]:= 10;
    Self.data.dmsmods.clasmods[1][dp_calmness]:= 20;  Self.data.dmsmods.clasmods[1][dp_educability]:= 0;
    Self.data.dmsmods.clasmods[1][dp_authority]:= 15;

    //����� ������
    Self.data.dmsmods.clasmods[2][dp_diligence]:= 5; Self.data.dmsmods.clasmods[2][dp_identity]:= 20;
    Self.data.dmsmods.clasmods[2][dp_calmness]:= 20;  Self.data.dmsmods.clasmods[2][dp_educability]:= 0;
    Self.data.dmsmods.clasmods[2][dp_authority]:= -10;

    //����� ������
    Self.data.dmsmods.clasmods[3][dp_diligence]:= 20; Self.data.dmsmods.clasmods[3][dp_identity]:= -10;
    Self.data.dmsmods.clasmods[3][dp_calmness]:= 10;  Self.data.dmsmods.clasmods[3][dp_educability]:= -10;
    Self.data.dmsmods.clasmods[3][dp_authority]:= 20;

    //����� ��������
    Self.data.dmsmods.clasmods[4][dp_diligence]:= 20; Self.data.dmsmods.clasmods[4][dp_identity]:= 10;
    Self.data.dmsmods.clasmods[4][dp_calmness]:= 20;  Self.data.dmsmods.clasmods[4][dp_educability]:= 0;
    Self.data.dmsmods.clasmods[4][dp_authority]:= 0;

    //����� �������
    Self.data.dmsmods.clasmods[5][dp_diligence]:= 10; Self.data.dmsmods.clasmods[5][dp_identity]:= 15;
    Self.data.dmsmods.clasmods[5][dp_calmness]:= 10;  Self.data.dmsmods.clasmods[5][dp_educability]:= 15;
    Self.data.dmsmods.clasmods[5][dp_authority]:= -20;

    //����� �������
    Self.data.dmsmods.clasmods[6][dp_diligence]:= -20; Self.data.dmsmods.clasmods[6][dp_identity]:= -15;
    Self.data.dmsmods.clasmods[6][dp_calmness]:= 10;  Self.data.dmsmods.clasmods[6][dp_educability]:= -10;
    Self.data.dmsmods.clasmods[6][dp_authority]:= 0;

    //����� ���������
    Self.data.dmsmods.clasmods[7][dp_diligence]:= 10; Self.data.dmsmods.clasmods[7][dp_identity]:= 20;
    Self.data.dmsmods.clasmods[7][dp_calmness]:= 20;  Self.data.dmsmods.clasmods[7][dp_educability]:= 20;
    Self.data.dmsmods.clasmods[7][dp_authority]:= 10;

    //������������ �������������
    //������������� ����� ���
    Self.data.dmsmods.origmods[0][dp_diligence]:= 20; Self.data.dmsmods.origmods[0][dp_identity]:= 10;
    Self.data.dmsmods.origmods[0][dp_calmness]:= 10;  Self.data.dmsmods.origmods[0][dp_educability]:= -10;
    Self.data.dmsmods.origmods[0][dp_authority]:= -10;

    //������������� ���-����
    Self.data.dmsmods.origmods[1][dp_diligence]:= -15; Self.data.dmsmods.origmods[1][dp_identity]:= -10;
    Self.data.dmsmods.origmods[1][dp_calmness]:= 10;  Self.data.dmsmods.origmods[1][dp_educability]:= 15;
    Self.data.dmsmods.origmods[1][dp_authority]:= 10;

    //������������� ��������� ���
    Self.data.dmsmods.origmods[2][dp_diligence]:= 10; Self.data.dmsmods.origmods[2][dp_identity]:= -5;
    Self.data.dmsmods.origmods[2][dp_calmness]:= 5;  Self.data.dmsmods.origmods[2][dp_educability]:= 5;
    Self.data.dmsmods.origmods[2][dp_authority]:= 15;

    //������������� �������
    Self.data.dmsmods.origmods[3][dp_diligence]:= -5; Self.data.dmsmods.origmods[3][dp_identity]:= 20;
    Self.data.dmsmods.origmods[3][dp_calmness]:= 15;  Self.data.dmsmods.origmods[3][dp_educability]:= 20;
    Self.data.dmsmods.origmods[3][dp_authority]:= -15;

    //������������ �������
    //������� ��������
    Self.data.dmsmods.factmods[0][dp_diligence]:= 10; Self.data.dmsmods.factmods[0][dp_identity]:= -20;
    Self.data.dmsmods.factmods[0][dp_calmness]:= -20;  Self.data.dmsmods.factmods[0][dp_educability]:= 0;
    Self.data.dmsmods.factmods[0][dp_authority]:= 0;

    //������� �������
    Self.data.dmsmods.factmods[1][dp_diligence]:= -20; Self.data.dmsmods.factmods[1][dp_identity]:= -15;
    Self.data.dmsmods.factmods[1][dp_calmness]:= 5;  Self.data.dmsmods.factmods[1][dp_educability]:= -5;
    Self.data.dmsmods.factmods[1][dp_authority]:= -5;

    //������� ��������
    Self.data.dmsmods.factmods[2][dp_diligence]:= 20; Self.data.dmsmods.factmods[2][dp_identity]:= 10;
    Self.data.dmsmods.factmods[2][dp_calmness]:= 10;  Self.data.dmsmods.factmods[2][dp_educability]:= 5;
    Self.data.dmsmods.factmods[2][dp_authority]:= 15;

    //������� ��������� �������
    Self.data.dmsmods.factmods[3][dp_diligence]:= 20; Self.data.dmsmods.factmods[3][dp_identity]:= 10;
    Self.data.dmsmods.factmods[3][dp_calmness]:= 15;  Self.data.dmsmods.factmods[3][dp_educability]:= 5;
    Self.data.dmsmods.factmods[3][dp_authority]:= 10;

    //������� �������
    Self.data.dmsmods.factmods[4][dp_diligence]:= 0; Self.data.dmsmods.factmods[4][dp_identity]:= 0;
    Self.data.dmsmods.factmods[4][dp_calmness]:= 0;  Self.data.dmsmods.factmods[4][dp_educability]:= 0;
    Self.data.dmsmods.factmods[4][dp_authority]:= 0;

    //������� ������������
    Self.data.dmsmods.factmods[5][dp_diligence]:= 20; Self.data.dmsmods.factmods[5][dp_identity]:= -10;
    Self.data.dmsmods.factmods[5][dp_calmness]:= -5;  Self.data.dmsmods.factmods[5][dp_educability]:= -10;
    Self.data.dmsmods.factmods[5][dp_authority]:= 20;

    //������� ���������
    Self.data.dmsmods.factmods[6][dp_diligence]:= 5; Self.data.dmsmods.factmods[6][dp_identity]:= 20;
    Self.data.dmsmods.factmods[6][dp_calmness]:= 20;  Self.data.dmsmods.factmods[6][dp_educability]:= 20;
    Self.data.dmsmods.factmods[6][dp_authority]:= 15;

    //������� ���� ������
    Self.data.dmsmods.factmods[7][dp_diligence]:= 20; Self.data.dmsmods.factmods[7][dp_identity]:= 15;
    Self.data.dmsmods.factmods[7][dp_calmness]:= 20;  Self.data.dmsmods.factmods[7][dp_educability]:= 15;
    Self.data.dmsmods.factmods[7][dp_authority]:= 20;

    //������� ���� ��������
    Self.data.dmsmods.factmods[8][dp_diligence]:= 20; Self.data.dmsmods.factmods[8][dp_identity]:= 15;
    Self.data.dmsmods.factmods[8][dp_calmness]:= 20;  Self.data.dmsmods.factmods[8][dp_educability]:= 15;
    Self.data.dmsmods.factmods[8][dp_authority]:= 20;

    //������� ���� �������
    Self.data.dmsmods.factmods[9][dp_diligence]:= 20; Self.data.dmsmods.factmods[9][dp_identity]:= 15;
    Self.data.dmsmods.factmods[9][dp_calmness]:= 20;  Self.data.dmsmods.factmods[9][dp_educability]:= 15;
    Self.data.dmsmods.factmods[9][dp_authority]:= 20;

    //������ �������� ����� ��������
    Self.data.actnames[ag_force]:='�������';    Self.data.actnames[ag_court]:='��������';
    Self.data.actnames[ag_stealth]:='��������'; Self.data.actnames[ag_investigation]:='������������';
    Self.data.actnames[ag_others]:='������';

    //���������� �� 12.09.2015
    //�������� ��������
    Self.data.ordnames[og_kill]:= '����������';       Self.data.ordnames[og_capture]:= '���������';
    Self.data.ordnames[og_interrogate]:= '�������';   Self.data.ordnames[og_search]:= '���������';
    Self.data.ordnames[og_freetime]:= '������ �����'; Self.data.ordnames[og_heresy]:= '�����';

    //���������� �� 16.07.2015
    //������ �������� ���������� DMS
    Self.data.dmsnames[dp_diligence]:= '����������������'; Self.data.dmsnames[dp_identity]:= '������������';
    Self.data.dmsnames[dp_calmness]:= '������������';      Self.data.dmsnames[dp_educability]:= '�����������';
    Self.data.dmsnames[dp_authority]:= '��������������';

    //���������� �� 08.09.2015
    //������ ���������� � ���������

    //�������� ��������

    //�������
    Self.data.actions[ag_force][0].name:= '�����������'; Self.data.actions[ag_force][1].name:= '�����';
    Self.data.actions[ag_force][2].name:= '������'; Self.data.actions[ag_force][3].name:= '�����������';
    Self.data.actions[ag_force][4].name:= '�����';

    //��������
    Self.data.actions[ag_court][0].name:= '�������'; Self.data.actions[ag_court][1].name:= '��������';
    Self.data.actions[ag_court][2].name:= '��������� ������'; Self.data.actions[ag_court][3].name:= '�����';
    Self.data.actions[ag_court][4].name:= '������� � ��������';

    //��������
    Self.data.actions[ag_stealth][0].name:= '�������������'; Self.data.actions[ag_stealth][1].name:= '��������';
    Self.data.actions[ag_stealth][2].name:= '�������'; Self.data.actions[ag_stealth][3].name:= '�������� ���������';
    Self.data.actions[ag_stealth][4].name:= '������';

    //������������
    Self.data.actions[ag_investigation][0].name:= '������ �����'; Self.data.actions[ag_investigation][1].name:= '������ ����';
    Self.data.actions[ag_investigation][2].name:= '�����������'; Self.data.actions[ag_investigation][3].name:= '������';
    Self.data.actions[ag_investigation][4].name:= '����� ��������';

    //������
    Self.data.actions[ag_others][0].name:= '��������'; Self.data.actions[ag_others][1].name:= '����� ����';
    Self.data.actions[ag_others][2].name:= '����������'; Self.data.actions[ag_others][3].name:= '�������';
    Self.data.actions[ag_others][4].name:= '�����';

    //�������� �������� (�������� ��������� �������)

    //�������
    Self.data.actions[ag_force][0].description:= ''; Self.data.actions[ag_force][1].description:= '';
    Self.data.actions[ag_force][2].description:= ''; Self.data.actions[ag_force][3].description:= '';
    Self.data.actions[ag_force][4].description:= '';

    //��������
    Self.data.actions[ag_court][0].description:= ''; Self.data.actions[ag_court][1].description:= '';
    Self.data.actions[ag_court][2].description:= ''; Self.data.actions[ag_court][3].description:= '';
    Self.data.actions[ag_court][4].description:= '';

    //��������
    Self.data.actions[ag_stealth][0].description:= ''; Self.data.actions[ag_stealth][1].description:= '';
    Self.data.actions[ag_stealth][2].description:= ''; Self.data.actions[ag_stealth][3].description:= '';
    Self.data.actions[ag_stealth][4].description:= '';

    //������������
    Self.data.actions[ag_investigation][0].description:= ''; Self.data.actions[ag_investigation][1].description:= '';
    Self.data.actions[ag_investigation][2].description:= ''; Self.data.actions[ag_investigation][3].description:= '';
    Self.data.actions[ag_investigation][4].description:= '';

    //������
    Self.data.actions[ag_others][0].description:= ''; Self.data.actions[ag_others][1].description:= '';
    Self.data.actions[ag_others][2].description:= ''; Self.data.actions[ag_others][3].description:= '';
    Self.data.actions[ag_others][4].description:= '';

    //����������� ������ ����� ����� ��� ��������� ��������

    //�������
    //�����������
    Self.data.actions[ag_force][0].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_force][0].targets[tk_place].Availible:= True;
    Self.data.actions[ag_force][0].targets[tk_person].Availible:= True;
    Self.data.actions[ag_force][0].targets[tk_item].Availible:= True;
    Self.data.actions[ag_force][0].targets[tk_self].Availible:= True;

    //�����
    Self.data.actions[ag_force][1].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_force][1].targets[tk_place].Availible:= True;
    Self.data.actions[ag_force][1].targets[tk_person].Availible:= False;
    Self.data.actions[ag_force][1].targets[tk_item].Availible:= False;
    Self.data.actions[ag_force][1].targets[tk_self].Availible:= False;

    //������
    Self.data.actions[ag_force][2].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_force][2].targets[tk_place].Availible:= True;
    Self.data.actions[ag_force][2].targets[tk_person].Availible:= True;
    Self.data.actions[ag_force][2].targets[tk_item].Availible:= True;
    Self.data.actions[ag_force][2].targets[tk_self].Availible:= False;

    //�����������
    Self.data.actions[ag_force][3].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_force][3].targets[tk_place].Availible:= False;
    Self.data.actions[ag_force][3].targets[tk_person].Availible:= False;
    Self.data.actions[ag_force][3].targets[tk_item].Availible:= True;
    Self.data.actions[ag_force][3].targets[tk_self].Availible:= False;

    //�����
    Self.data.actions[ag_force][4].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_force][4].targets[tk_place].Availible:= False;
    Self.data.actions[ag_force][4].targets[tk_person].Availible:= True;
    Self.data.actions[ag_force][4].targets[tk_item].Availible:= False;
    Self.data.actions[ag_force][4].targets[tk_self].Availible:= False;

    //��������
    //�������
    Self.data.actions[ag_court][0].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_court][0].targets[tk_place].Availible:= True;
    Self.data.actions[ag_court][0].targets[tk_person].Availible:= True;
    Self.data.actions[ag_court][0].targets[tk_item].Availible:= False;
    Self.data.actions[ag_court][0].targets[tk_self].Availible:= False;

    //��������
    Self.data.actions[ag_court][1].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_court][1].targets[tk_place].Availible:= True;
    Self.data.actions[ag_court][1].targets[tk_person].Availible:= True;
    Self.data.actions[ag_court][1].targets[tk_item].Availible:= True;
    Self.data.actions[ag_court][1].targets[tk_self].Availible:= False;

    //��������� ������
    Self.data.actions[ag_court][2].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_court][2].targets[tk_place].Availible:= True;
    Self.data.actions[ag_court][2].targets[tk_person].Availible:= False;
    Self.data.actions[ag_court][2].targets[tk_item].Availible:= False;
    Self.data.actions[ag_court][2].targets[tk_self].Availible:= False;

    //�����
    Self.data.actions[ag_court][3].targets[tk_nondef].Availible:= True;
    Self.data.actions[ag_court][3].targets[tk_place].Availible:= True;
    Self.data.actions[ag_court][3].targets[tk_person].Availible:= True;
    Self.data.actions[ag_court][3].targets[tk_item].Availible:= True;
    Self.data.actions[ag_court][3].targets[tk_self].Availible:= False;

    //������� � ��������
    Self.data.actions[ag_court][4].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_court][4].targets[tk_place].Availible:= True;
    Self.data.actions[ag_court][4].targets[tk_person].Availible:= True;
    Self.data.actions[ag_court][4].targets[tk_item].Availible:= False;
    Self.data.actions[ag_court][4].targets[tk_self].Availible:= False;

    //��������
    //�������������
    Self.data.actions[ag_stealth][0].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_stealth][0].targets[tk_place].Availible:= True;
    Self.data.actions[ag_stealth][0].targets[tk_person].Availible:= False;
    Self.data.actions[ag_stealth][0].targets[tk_item].Availible:= False;
    Self.data.actions[ag_stealth][0].targets[tk_self].Availible:= False;

    //��������
    Self.data.actions[ag_stealth][1].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_stealth][1].targets[tk_place].Availible:= False;
    Self.data.actions[ag_stealth][1].targets[tk_person].Availible:= True;
    Self.data.actions[ag_stealth][1].targets[tk_item].Availible:= False;
    Self.data.actions[ag_stealth][1].targets[tk_self].Availible:= False;

    //�������
    Self.data.actions[ag_stealth][2].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_stealth][2].targets[tk_place].Availible:= False;
    Self.data.actions[ag_stealth][2].targets[tk_person].Availible:= True;
    Self.data.actions[ag_stealth][2].targets[tk_item].Availible:= True;
    Self.data.actions[ag_stealth][2].targets[tk_self].Availible:= False;

    //��������� ���������
    Self.data.actions[ag_stealth][3].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_stealth][3].targets[tk_place].Availible:= True;
    Self.data.actions[ag_stealth][3].targets[tk_person].Availible:= False;
    Self.data.actions[ag_stealth][3].targets[tk_item].Availible:= True;
    Self.data.actions[ag_stealth][3].targets[tk_self].Availible:= True;

    //������
    Self.data.actions[ag_stealth][4].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_stealth][4].targets[tk_place].Availible:= True;
    Self.data.actions[ag_stealth][4].targets[tk_person].Availible:= True;
    Self.data.actions[ag_stealth][4].targets[tk_item].Availible:= False;
    Self.data.actions[ag_stealth][4].targets[tk_self].Availible:= False;

    //������������
    //������ �����
    Self.data.actions[ag_investigation][0].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_investigation][0].targets[tk_place].Availible:= True;
    Self.data.actions[ag_investigation][0].targets[tk_person].Availible:= False;
    Self.data.actions[ag_investigation][0].targets[tk_item].Availible:= False;
    Self.data.actions[ag_investigation][0].targets[tk_self].Availible:= False;

    //������ ����
    Self.data.actions[ag_investigation][1].targets[tk_nondef].Availible:= True;
    Self.data.actions[ag_investigation][1].targets[tk_place].Availible:= False;
    Self.data.actions[ag_investigation][1].targets[tk_person].Availible:= False;
    Self.data.actions[ag_investigation][1].targets[tk_item].Availible:= False;
    Self.data.actions[ag_investigation][1].targets[tk_self].Availible:= False;

    //�����������
    Self.data.actions[ag_investigation][2].targets[tk_nondef].Availible:= True;
    Self.data.actions[ag_investigation][2].targets[tk_place].Availible:= False;
    Self.data.actions[ag_investigation][2].targets[tk_person].Availible:= False;
    Self.data.actions[ag_investigation][2].targets[tk_item].Availible:= True;
    Self.data.actions[ag_investigation][2].targets[tk_self].Availible:= False;

    //������
    Self.data.actions[ag_investigation][3].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_investigation][3].targets[tk_place].Availible:= False;
    Self.data.actions[ag_investigation][3].targets[tk_person].Availible:= True;
    Self.data.actions[ag_investigation][3].targets[tk_item].Availible:= False;
    Self.data.actions[ag_investigation][3].targets[tk_self].Availible:= False;

    //����� ����������
    Self.data.actions[ag_investigation][4].targets[tk_nondef].Availible:= True;
    Self.data.actions[ag_investigation][4].targets[tk_place].Availible:= True;
    Self.data.actions[ag_investigation][4].targets[tk_person].Availible:= False;
    Self.data.actions[ag_investigation][4].targets[tk_item].Availible:= False;
    Self.data.actions[ag_investigation][4].targets[tk_self].Availible:= False;

    //������
    //��������
    Self.data.actions[ag_others][0].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_others][0].targets[tk_place].Availible:= True;
    Self.data.actions[ag_others][0].targets[tk_person].Availible:= True;
    Self.data.actions[ag_others][0].targets[tk_item].Availible:= False;
    Self.data.actions[ag_others][0].targets[tk_self].Availible:= False;

    //����� ����
    Self.data.actions[ag_others][1].targets[tk_nondef].Availible:= True;
    Self.data.actions[ag_others][1].targets[tk_place].Availible:= True;
    Self.data.actions[ag_others][1].targets[tk_person].Availible:= True;
    Self.data.actions[ag_others][1].targets[tk_item].Availible:= False;
    Self.data.actions[ag_others][1].targets[tk_self].Availible:= False;

    //����������
    Self.data.actions[ag_others][2].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_others][2].targets[tk_place].Availible:= False;
    Self.data.actions[ag_others][2].targets[tk_person].Availible:= True;
    Self.data.actions[ag_others][2].targets[tk_item].Availible:= False;
    Self.data.actions[ag_others][2].targets[tk_self].Availible:= True;

    //�������
    Self.data.actions[ag_others][3].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_others][3].targets[tk_place].Availible:= False;
    Self.data.actions[ag_others][3].targets[tk_person].Availible:= True;
    Self.data.actions[ag_others][3].targets[tk_item].Availible:= False;
    Self.data.actions[ag_others][3].targets[tk_self].Availible:= True;

    //�����
    Self.data.actions[ag_others][4].targets[tk_nondef].Availible:= False;
    Self.data.actions[ag_others][4].targets[tk_place].Availible:= False;
    Self.data.actions[ag_others][4].targets[tk_person].Availible:= False;
    Self.data.actions[ag_others][4].targets[tk_item].Availible:= False;
    Self.data.actions[ag_others][4].targets[tk_self].Availible:= True;

    //����� ����� (������������)

    //�������
    //�����������
    Self.data.actions[ag_force][0].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_force][0].targets[tk_place].MaxAmount:= 1;
    Self.data.actions[ag_force][0].targets[tk_person].MaxAmount:= MAX_PARTY_SIZE + 1;
    Self.data.actions[ag_force][0].targets[tk_item].MaxAmount:= 1;
    Self.data.actions[ag_force][0].targets[tk_self].MaxAmount:= 1;

    //�����
    Self.data.actions[ag_force][1].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_force][1].targets[tk_place].MaxAmount:= 1;
    Self.data.actions[ag_force][1].targets[tk_person].MaxAmount:= -1;
    Self.data.actions[ag_force][1].targets[tk_item].MaxAmount:= -1;
    Self.data.actions[ag_force][1].targets[tk_self].MaxAmount:= -1;

    //������
    Self.data.actions[ag_force][2].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_force][2].targets[tk_place].MaxAmount:= 1;
    Self.data.actions[ag_force][2].targets[tk_person].MaxAmount:= MAX_PARTY_SIZE + 1;
    Self.data.actions[ag_force][2].targets[tk_item].MaxAmount:= 1;
    Self.data.actions[ag_force][2].targets[tk_self].MaxAmount:= -1;

    //�����������
    Self.data.actions[ag_force][3].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_force][3].targets[tk_place].MaxAmount:= -1;
    Self.data.actions[ag_force][3].targets[tk_person].MaxAmount:= -1;
    Self.data.actions[ag_force][3].targets[tk_item].MaxAmount:= 3;
    Self.data.actions[ag_force][3].targets[tk_self].MaxAmount:= -1;

    //�����
    Self.data.actions[ag_force][4].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_force][4].targets[tk_place].MaxAmount:= -1;
    Self.data.actions[ag_force][4].targets[tk_person].MaxAmount:= MAX_PARTY_SIZE + 1;
    Self.data.actions[ag_force][4].targets[tk_item].MaxAmount:= -1;
    Self.data.actions[ag_force][4].targets[tk_self].MaxAmount:= -1;

    //��������
    //�������
    Self.data.actions[ag_court][0].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_court][0].targets[tk_place].MaxAmount:= 1;
    Self.data.actions[ag_court][0].targets[tk_person].MaxAmount:= 1;
    Self.data.actions[ag_court][0].targets[tk_item].MaxAmount:= -1;
    Self.data.actions[ag_court][0].targets[tk_self].MaxAmount:= -1;

    //���������
    Self.data.actions[ag_court][1].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_court][1].targets[tk_place].MaxAmount:= 1;
    Self.data.actions[ag_court][1].targets[tk_person].MaxAmount:= 1;
    Self.data.actions[ag_court][1].targets[tk_item].MaxAmount:= 1;
    Self.data.actions[ag_court][1].targets[tk_self].MaxAmount:= -1;

    //��������� ������
    Self.data.actions[ag_court][2].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_court][2].targets[tk_place].MaxAmount:= 1;
    Self.data.actions[ag_court][2].targets[tk_person].MaxAmount:= -1;
    Self.data.actions[ag_court][2].targets[tk_item].MaxAmount:= -1;
    Self.data.actions[ag_court][2].targets[tk_self].MaxAmount:= -1;

    //�����
    Self.data.actions[ag_court][3].targets[tk_nondef].MaxAmount:= 1;
    Self.data.actions[ag_court][3].targets[tk_place].MaxAmount:= 1;
    Self.data.actions[ag_court][3].targets[tk_person].MaxAmount:= 1;
    Self.data.actions[ag_court][3].targets[tk_item].MaxAmount:= 1;
    Self.data.actions[ag_court][3].targets[tk_self].MaxAmount:= -1;

    //������� � ��������
    Self.data.actions[ag_court][4].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_court][4].targets[tk_place].MaxAmount:= 1;
    Self.data.actions[ag_court][4].targets[tk_person].MaxAmount:= 1;
    Self.data.actions[ag_court][4].targets[tk_item].MaxAmount:= -1;
    Self.data.actions[ag_court][4].targets[tk_self].MaxAmount:= -1;

    //��������
    //�������������
    Self.data.actions[ag_stealth][0].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_stealth][0].targets[tk_place].MaxAmount:= 1;
    Self.data.actions[ag_stealth][0].targets[tk_person].MaxAmount:= -1;
    Self.data.actions[ag_stealth][0].targets[tk_item].MaxAmount:= 1;
    Self.data.actions[ag_stealth][0].targets[tk_self].MaxAmount:= 1;

    //��������
    Self.data.actions[ag_stealth][1].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_stealth][1].targets[tk_place].MaxAmount:= -1;
    Self.data.actions[ag_stealth][1].targets[tk_person].MaxAmount:= MAX_PARTY_SIZE + 1;
    Self.data.actions[ag_stealth][1].targets[tk_item].MaxAmount:= -1;
    Self.data.actions[ag_stealth][1].targets[tk_self].MaxAmount:= -1;

    //�������
    Self.data.actions[ag_stealth][2].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_stealth][2].targets[tk_place].MaxAmount:= -1;
    Self.data.actions[ag_stealth][2].targets[tk_person].MaxAmount:= 1;
    Self.data.actions[ag_stealth][2].targets[tk_item].MaxAmount:= 1;
    Self.data.actions[ag_stealth][2].targets[tk_self].MaxAmount:= -1;

    //��������� ���������
    Self.data.actions[ag_stealth][3].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_stealth][3].targets[tk_place].MaxAmount:= 1;
    Self.data.actions[ag_stealth][3].targets[tk_person].MaxAmount:= -1;
    Self.data.actions[ag_stealth][3].targets[tk_item].MaxAmount:= 1;
    Self.data.actions[ag_stealth][3].targets[tk_self].MaxAmount:= 1;

    //������
    Self.data.actions[ag_stealth][4].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_stealth][4].targets[tk_place].MaxAmount:= 1;
    Self.data.actions[ag_stealth][4].targets[tk_person].MaxAmount:= 1;
    Self.data.actions[ag_stealth][4].targets[tk_item].MaxAmount:= -1;
    Self.data.actions[ag_stealth][4].targets[tk_self].MaxAmount:= -1;

    //������������
    //������ �����
    Self.data.actions[ag_investigation][0].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_investigation][0].targets[tk_place].MaxAmount:= 1;
    Self.data.actions[ag_investigation][0].targets[tk_person].MaxAmount:= -1;
    Self.data.actions[ag_investigation][0].targets[tk_item].MaxAmount:= -1;
    Self.data.actions[ag_investigation][0].targets[tk_self].MaxAmount:= -1;

    //������ ����
    Self.data.actions[ag_investigation][1].targets[tk_nondef].MaxAmount:= 1;
    Self.data.actions[ag_investigation][1].targets[tk_place].MaxAmount:= -1;
    Self.data.actions[ag_investigation][1].targets[tk_person].MaxAmount:= -1;
    Self.data.actions[ag_investigation][1].targets[tk_item].MaxAmount:= -1;
    Self.data.actions[ag_investigation][1].targets[tk_self].MaxAmount:= -1;

    //�����������
    Self.data.actions[ag_investigation][2].targets[tk_nondef].MaxAmount:= 1;
    Self.data.actions[ag_investigation][2].targets[tk_place].MaxAmount:= -1;
    Self.data.actions[ag_investigation][2].targets[tk_person].MaxAmount:= -1;
    Self.data.actions[ag_investigation][2].targets[tk_item].MaxAmount:= 1;
    Self.data.actions[ag_investigation][2].targets[tk_self].MaxAmount:= -1;

    //������
    Self.data.actions[ag_investigation][3].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_investigation][3].targets[tk_place].MaxAmount:= -1;
    Self.data.actions[ag_investigation][3].targets[tk_person].MaxAmount:= 1;
    Self.data.actions[ag_investigation][3].targets[tk_item].MaxAmount:= -1;
    Self.data.actions[ag_investigation][3].targets[tk_self].MaxAmount:= -1;

    //����� ����������
    Self.data.actions[ag_investigation][4].targets[tk_nondef].MaxAmount:= 1;
    Self.data.actions[ag_investigation][4].targets[tk_place].MaxAmount:= 1;
    Self.data.actions[ag_investigation][4].targets[tk_person].MaxAmount:= -1;
    Self.data.actions[ag_investigation][4].targets[tk_item].MaxAmount:= -1;
    Self.data.actions[ag_investigation][4].targets[tk_self].MaxAmount:= -1;

    //������
    //��������
    Self.data.actions[ag_others][0].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_others][0].targets[tk_place].MaxAmount:= 1;
    Self.data.actions[ag_others][0].targets[tk_person].MaxAmount:= 1;
    Self.data.actions[ag_others][0].targets[tk_item].MaxAmount:= -1;
    Self.data.actions[ag_others][0].targets[tk_self].MaxAmount:= -1;

    //����� ����
    Self.data.actions[ag_others][1].targets[tk_nondef].MaxAmount:= 1;
    Self.data.actions[ag_others][1].targets[tk_place].MaxAmount:= 1;
    Self.data.actions[ag_others][1].targets[tk_person].MaxAmount:= 1;
    Self.data.actions[ag_others][1].targets[tk_item].MaxAmount:= -1;
    Self.data.actions[ag_others][1].targets[tk_self].MaxAmount:= -1;

    //����������
    Self.data.actions[ag_others][2].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_others][2].targets[tk_place].MaxAmount:= -1;
    Self.data.actions[ag_others][2].targets[tk_person].MaxAmount:= 1;
    Self.data.actions[ag_others][2].targets[tk_item].MaxAmount:= -1;
    Self.data.actions[ag_others][2].targets[tk_self].MaxAmount:= 1;

    //�������
    Self.data.actions[ag_others][3].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_others][3].targets[tk_place].MaxAmount:= -1;
    Self.data.actions[ag_others][3].targets[tk_person].MaxAmount:= 1;
    Self.data.actions[ag_others][3].targets[tk_item].MaxAmount:= -1;
    Self.data.actions[ag_others][3].targets[tk_self].MaxAmount:= 1;

    //�����
    Self.data.actions[ag_others][4].targets[tk_nondef].MaxAmount:= -1;
    Self.data.actions[ag_others][4].targets[tk_place].MaxAmount:= -1;
    Self.data.actions[ag_others][4].targets[tk_person].MaxAmount:= -1;
    Self.data.actions[ag_others][4].targets[tk_item].MaxAmount:= -1;
    Self.data.actions[ag_others][4].targets[tk_self].MaxAmount:= 1;

    //����� ������������ (��������� � ������������)

    //�������
    Self.data.actions[ag_force][0].actors[0]:= 1; Self.data.actions[ag_force][0].actors[1]:= MAX_PARTY_SIZE + 1; //�����������
    Self.data.actions[ag_force][1].actors[0]:= 1; Self.data.actions[ag_force][1].actors[1]:= MAX_PARTY_SIZE + 1; //�����
    Self.data.actions[ag_force][2].actors[0]:= 1; Self.data.actions[ag_force][2].actors[1]:= MAX_PARTY_SIZE + 1; //������
    Self.data.actions[ag_force][3].actors[0]:= 1; Self.data.actions[ag_force][3].actors[1]:= MAX_PARTY_SIZE + 1; //�����������
    Self.data.actions[ag_force][4].actors[0]:= 1; Self.data.actions[ag_force][4].actors[1]:= (MAX_PARTY_SIZE + 1) div 2; //�����

    //��������
    Self.data.actions[ag_court][0].actors[0]:= 1; Self.data.actions[ag_court][0].actors[1]:= (MAX_PARTY_SIZE + 1) div 2; //�������
    Self.data.actions[ag_court][1].actors[0]:= 1; Self.data.actions[ag_court][1].actors[1]:= (MAX_PARTY_SIZE + 1) div 2; //��������
    Self.data.actions[ag_court][2].actors[0]:= 1; Self.data.actions[ag_court][2].actors[1]:= MAX_PARTY_SIZE + 1; //�������� ������
    Self.data.actions[ag_court][3].actors[0]:= 1; Self.data.actions[ag_court][3].actors[1]:= (MAX_PARTY_SIZE + 1) div 2; //�����
    Self.data.actions[ag_court][4].actors[0]:= 1; Self.data.actions[ag_court][4].actors[1]:= 1; //������� � ��������

    //��������
    Self.data.actions[ag_stealth][0].actors[0]:= 1; Self.data.actions[ag_stealth][0].actors[1]:= (MAX_PARTY_SIZE + 1) div 2; //�������������
    Self.data.actions[ag_stealth][1].actors[0]:= 1; Self.data.actions[ag_stealth][1].actors[1]:= (MAX_PARTY_SIZE + 1) div 2; //��������
    Self.data.actions[ag_stealth][2].actors[0]:= 1; Self.data.actions[ag_stealth][2].actors[1]:= (MAX_PARTY_SIZE + 1) div 2; //�������
    Self.data.actions[ag_stealth][3].actors[0]:= 1; Self.data.actions[ag_stealth][3].actors[1]:= (MAX_PARTY_SIZE + 1) div 2; //��������� ���������
    Self.data.actions[ag_stealth][4].actors[0]:= 1; Self.data.actions[ag_stealth][4].actors[1]:= (MAX_PARTY_SIZE + 1) div 2; //������

    //������������
    Self.data.actions[ag_investigation][0].actors[0]:= 1; Self.data.actions[ag_investigation][0].actors[1]:= (MAX_PARTY_SIZE + 1) div 2; //������ �����
    Self.data.actions[ag_investigation][1].actors[0]:= 1; Self.data.actions[ag_investigation][1].actors[1]:= (MAX_PARTY_SIZE + 1) div 2; //������ ����
    Self.data.actions[ag_investigation][2].actors[0]:= 1; Self.data.actions[ag_investigation][2].actors[1]:= 1; //�����������
    Self.data.actions[ag_investigation][3].actors[0]:= 1; Self.data.actions[ag_investigation][3].actors[1]:= 2; //������
    Self.data.actions[ag_investigation][4].actors[0]:= 1; Self.data.actions[ag_investigation][4].actors[1]:= MAX_PARTY_SIZE + 1; //����� ����������

    //������
    Self.data.actions[ag_others][0].actors[0]:= 1; Self.data.actions[ag_others][0].actors[1]:= (MAX_PARTY_SIZE + 1) div 2; //��������
    Self.data.actions[ag_others][1].actors[0]:= 1; Self.data.actions[ag_others][1].actors[1]:= 1; //����� ����
    Self.data.actions[ag_others][2].actors[0]:= 1; Self.data.actions[ag_others][2].actors[1]:= 1; //����������
    Self.data.actions[ag_others][3].actors[0]:= 1; Self.data.actions[ag_others][3].actors[1]:= 1; //�������
    Self.data.actions[ag_others][4].actors[0]:= 1; Self.data.actions[ag_others][4].actors[1]:= 1; //�����

  end;
//<-------------------------------------------------------------------------->\\
//<-------------------------------------------------------------------------->\\

//<-------------------------------------------------------------------------->\\
//<------------------------����� ���������� (TCharacter)--------------------->\\
//<-------------------------------------------------------------------------->\\

//����������� ���
  constructor THuman.create (Stock: TStorage);
  //��������� �� 01.02.2015 - ������ ��������� ������������� ����������
  //��������� �� 04.02.2015-05.02.2015 - ��������� ���������������� ������� ���������
  //��������� �� 14.07.2015 - ��������� ������������� ���������� ��������� � DMS
  var
    i,j,k: Byte;     //������������ �������� ������
    ag: TActGroups;  //������� ��� �������� ����� ��������
    dp: TDMSParams;  //������� ��� �������� ���������� DMS
    factsum: TSCent; //��������� ���������� ��� ������������ ������� (-20..20)
  begin
    //��������� ����
    Randomize;
    //���� ��������� ����� �� 0 �� 1000 - ������, ��� �������, ����� �������
    Self.props.gender:= (((Random(2)+1) div 2) = 0);
    Self.props.isfree:= True;
    //���������� �� 20.08.2015
    //���� ������ ���
    Self.props.address:= -1; //�� ��������� ��� ������ �� ����������
    //��������� ���� ������� ����
    Self.props.origin:= Random(ORIGINS_COUNT + 1);
    //����������� ����� �� 3 ���� (��������, ����������� �� �������� ������ � ����� ����� ������ ������)
    for i:=0 to 2 do
    begin
      Self.props.name[i][0]:= Random(4); //����������� �������� ������, � ������� ��������� ����� ����� (������ infr �� ������������, �.�. �������� �� ����)
      Self.props.name[i][1]:= Random(NAMES_COUNT + 1); //����������� ������ ����� ������ �������� ������
    end;
    //��������� ���������
    //������������
    Self.props.outlook[ol_bodytype]:= Random(FEATS_COUNT + 1);
    //���� ����
    Self.props.outlook[ol_skin]:= Random(FEATS_COUNT + 1);
    //���� ����
    Self.props.outlook[ol_eyes]:= Random(FEATS_COUNT + 1);
    //���� �����
    Self.props.outlook[ol_hair]:= Random(FEATS_COUNT + 1);
    //������ �������
    Self.props.outlook[ol_perk1]:= Random(PERKS_COUNT + 1);
    repeat
      Self.props.outlook[ol_perk2]:= Random(PERKS_COUNT + 1);
    until (Self.props.outlook[ol_perk2] <> Self.props.outlook[ol_perk1]);
    repeat
      Self.props.outlook[ol_perk3]:= Random(PERKS_COUNT + 1);
    until ((Self.props.outlook[ol_perk3] <> Self.props.outlook[ol_perk1]) and (Self.props.outlook[ol_perk3] <> Self.props.outlook[ol_perk2]));
    //��������� ��������
    Self.props.age:= genrnd(AGE_BASE + Random(AGE_SEED), AGE_DIFF + Random(AGE_DIFF));
    //���������� � ��������� �� 01.02.2015
    //������ ��������� ������� ������� � ��������, ��������� ��������� �������������� � ���������� �������
    //������� ��������: 1-3)�������� ������-��������-������� (�.�. ����� ����������� �����������)
    //4)������� 5)��������� 6)������������ 7)�������� 8)������� 9)������� 10)���������
    //������ �������� ��������� - �������� ���� �� ���������� ����������� ��� ��������� ������ �������� (������������� ������������ ��������)
    //���������������� ���������� �������� (��������� �������� - ����)�
    for i:= 0 to FACTIONS_COUNT do
      Self.props.factions[i]:= False;
    //�������� �� �������������� � ���� ������� (��� �� ������ ������������ � ��������, ���� ������ � ���� ��������)
    if (Random(DICE_D100 + 1) <= Stock.data.fprobs[9]) then
      Self.props.factions[9]:= True;
    //�������� �� �������������� � ���� �������� (��� �� ������ ������������ � ���� �������)
    if (Random(DICE_D100 + 1) <= Stock.data.fprobs[8]) and (Self.props.factions[9] = False) then
      Self.props.factions[8]:= True;
    //�������� �� �������������� � ���� ������ (��� �� ������ ������������ � ���� ������� � ���� ��������)
    if (Random(DICE_D100 + 1) <= Stock.data.fprobs[7]) and (Self.props.factions[9] = False) and (Self.props.factions[8] = False) then
      Self.props.factions[7]:= True;
    //�������� �� �������������� � �������� (��� �� ������ ������������ � ���� ������, ���� ��������, ���� �������)
    if (Random(DICE_D100 + 1) <= Stock.data.fprobs[4]) and (Self.props.factions[9] = False) and (Self.props.factions[8] = False) and (Self.props.factions[7] = False) then
      Self.props.factions[4]:= True;
    //�������� �� �������������� � ���������
    if (Random(DICE_D100 + 1) <= Stock.data.fprobs[6]) then
      Self.props.factions[6]:= True;
    //�������� �� �������������� � ������������ (��� �� ������ ������������ � ���������)
    if (Random(DICE_D100 + 1) <= Stock.data.fprobs[5]) and (Self.props.factions[6] = False) then
      Self.props.factions[5]:= True;
    //�������� �� �������������� � �������� (��� �� ������ ������������ � ������������ � ���������)
    if (Random(DICE_D100 + 1) <= Stock.data.fprobs[2]) and (Self.props.factions[6] = False) and (Self.props.factions[5] = False) then
      Self.props.factions[2]:= True;
    //�������� �� �������������� � �������� (��� �� ������ ������������ � ��������, ������������ � ���������)
    if (Random(DICE_D100 + 1) <= Stock.data.fprobs[1]) and (Self.props.factions[6] = False) and (Self.props.factions[5] = False) and (Self.props.factions[2] = False) then
      Self.props.factions[1]:= True;
    //�������� �� �������������� � ������� (��� �� ������ ������������ � �������� � ��������)
    if (Random(DICE_D100 + 1) <= Stock.data.fprobs[3]) and (Self.props.factions[1] = False) and (Self.props.factions[2] = False) then
      Self.props.factions[3]:= True;
    //�������� �� �������������� � ��������� (��� �� ������ ������������ � ��������, �������, ������������ � ���������)
    if (Self.props.factions[2] = False) and (Self.props.factions[3] = False) and (Self.props.factions[5] = False) and (Self.props.factions[6] = False) then
      Self.props.factions[0]:= True;
    //��������� ���������� ��������� �� ��������� ��� = ���(20) + ���, ���: ��� - �������� �������� ���������, ��� - ������� ��������� ���������� ����� �� 1 �� 20, ��� - ����� ������� ����
    for i:=0 to STATS_COUNT do
      Self.props.stats[i]:= (Random(DICE_D20) + 2) + Stock.data.sbonus[Self.props.origin, i];
    //��������
    Self.props.psychotype:= Random(89) div 10; // ����������� ��������� ���
    //����������� ������������� ���
    Self.props.specialty:= CLASS_COUNT + 1; //���������������� �������������� ������������� (������������� ��������������� ��� �������� ������������ ��������� - 0..7)
    i:= 0; //������������� �������� ��� �������� ��������������
    k:= 0;
    repeat
      if (i > CLASS_COUNT) then i:= 0; //���� �������� �������� �������� (0..7) �� ������� ������� � ������
      //���� ��������� ����� ������������ � �������� (0..�), ��� � - ����������� ������������� ��� ������� ���� ������� ����, ��������� ��������� ��� �������������
      if((Random(DICE_D100 + 1)+1) <= Stock.data.sprobs[Self.props.origin,i]) then
        Self.props.specialty:= i;
      i:= i+1; //�������� ������� �� ���� �������
      k:= k+1; //������� �������� (��� ���������� ������
    until (Self.props.specialty < (CLASS_COUNT + 1)) or (k >= 100); //������� ������ �� ����� - ��������� �������������� ������������� � �������� 0..7 ���� ������� 100 ��������������� ��������
    //��������� ������ � �������, � ������� �� �������
    for i:=0 to FACTIONS_COUNT do
    //���� ��� ����������� � �������, ������ ��������� ������
      if (Self.props.factions[i]) then
      begin
        Self.props.ladder[i]:=4; //���������������� ������ ��� �������� ���������� (0..3)
        j:= 0; //��������� �������� �� ����
        k:= 0;
        repeat
          if (j > 3) then j:= 0; //���� ������� ����� �� �������� ���������, ������� ��� � ������
          //���� ��������� ����� �� 0 �� 100 ����� � ��������� 0..�, ��� � - ����������� ������, ���������� �������� ���� ������ �������� �������� ��������
          if (Random(101) <= Stock.data.lprobs[j]) then
            Self.props.ladder[i]:= j;
          j:= j + 1;
          k:= k + 1;
        until (Self.props.ladder[i] < 4) or (k >= 100);
      end;
    //���������� �� 14.07.2015
    //������������� �������� ���������� DMS � �����������
    //������ �����������
    //���������������� ������� �����������
      for ag:= ag_force to ag_others do
      begin
        Self.props.addictions[ag]:= Random(81) - 40; //������ �������� ������� ����������� ���������������� ��������� ������ -40..40
      end;
    //���������� ������������� � ������� �����������
      for ag:= ag_force to ag_others do
      begin
      //����������� ������
        Self.props.addictions[ag]:= Self.props.addictions[ag] + Stock.data.addmods.clasmods[Self.props.specialty][ag];
      //����������� �������������
        Self.props.addictions[ag]:= Self.props.addictions[ag] + Stock.data.addmods.origmods[Self.props.origin][ag];
      //������������ �������
      //����������������
        factsum:= 0;
      //������ ���������� ������������ �� �������� ��������� DMS
        for i:= 0 to FACTIONS_COUNT do
        begin
        //����������� ������ ������������ �������, � ������� ����������� ���
          if Self.props.factions[i] then
          begin
            factsum:= factsum + Stock.data.addmods.factmods[i][ag];
          //���� ����� ����� �� �������, ������� � ���������� ��������
            if (factsum < -FACT_MOD_LIM) then
              factsum:= -FACT_MOD_LIM;
            if (factsum > FACT_MOD_LIM) then
              factsum:= FACT_MOD_LIM;
          end;
        end;
      //���������� ���������� ������������ �������
        Self.props.addictions[ag]:= Self.props.addictions[ag] + factsum;
      end;
    //������ ���������� DMS
    //���������������� ������� ���������� DMS ���
      for dp:= dp_diligence to dp_authority do
      begin
        Self.props.dmsparams[dp]:= Random(81) - 40; //������ �������� DMS ��� ���������������� ��� ��������� ����� -40..40
      end;
    //���������� ������������� ���������� DMS
      for dp:= dp_diligence to dp_authority do
      begin
      //����������� ������
        Self.props.dmsparams[dp]:= Self.props.dmsparams[dp] + Stock.data.dmsmods.clasmods[Self.props.specialty][dp];
      //������������ �������������
        Self.props.dmsparams[dp]:= Self.props.dmsparams[dp] + Stock.data.dmsmods.origmods[Self.props.origin][dp];
      //������������ �������
      //����������������
        factsum:= 0;
      //������ ���������� ������������ �� �������� ��������� DMS
        for i:= 0 to FACTIONS_COUNT do
        begin
        //����������� ������ ������������ �������, � ������� ����������� ���
          if Self.props.factions[i] then
          begin
            factsum:= factsum + Stock.data.dmsmods.factmods[i][dp];
          //���� ����� ����� �� �������, ������� � ���������� ��������
            if (factsum < -FACT_MOD_LIM) then
              factsum:= -FACT_MOD_LIM;
            if (factsum > FACT_MOD_LIM) then
              factsum:= FACT_MOD_LIM;
          end;
        end;
      //���������� ���������� ������������ DMS
        Self.props.dmsparams[dp]:= Self.props.dmsparams[dp] + factsum;
      end;
    //���������� �� 04.02.2015-05.02.2015
    //���������������� ������� ���������
    for i:=0 to CONTACTS_COUNT do
      Self.props.contacts[i]:= -1; //��� ������� ��������������� � -1 (��� �������� ���������)
    //�������������� �������� � 1 �� ��� ���������� ������ ���������� ��������� �����
    Sleep(1);
  end;

//����������� ������ ��� � ��������� ������ �����
  constructor THuman.create(data: THumanData);
  begin
    inherited create;
    Self.props:= data;
  end;

//���������� ���
  destructor THuman.destroy;
  begin
    inherited destroy;
  end;

//<-------------------------------------------------------------------------->\\
//<-------------------------------------------------------------------------->\\

//<-------------------------------------------------------------------------->\\
//<-----------------------------����� ����� (THouse)------------------------->\\
//<-------------------------------------------------------------------------->\\

//���������� �� 27.07.2015 - ����������� ������ ����
//����������� ������ ����
  constructor THouse.create;
  var
    i: byte;
  begin
    inherited create;
    //������������� ������� ������� ������
    for i:=0 to 9 do
      Self.people[i]:= 0;
    //to-do: ��������� ������
  end;

//���������� �� 11.08.2015 - ���������� ������ ����
//���������� ������ ����
  destructor THouse.destroy;
  begin
    inherited destroy;
  end;

//<-------------------------------------------------------------------------->\\
//<-------------------------------------------------------------------------->\\

//<-------------------------------------------------------------------------->\\
//<-----------------------------����� ������ (TCity)------------------------->\\
//<-------------------------------------------------------------------------->\\

//����������� ������ ������
  constructor TCity.create(populace: integer);
  var
    i, count: integer;
  begin
    inherited create;
  //������ ���������� ���������� ����� ��� ������� ��������� ������
  //���� ����������� ������� ������� �� ������� ������ ���� ������ - �������� ����� ������� ����� ������� ���������� ��� �������
  //����� �������� ��� ���� ��� �������������
    if ((populace mod HOUSE_CAPACITY) = 0) then
      count:= populace div (HOUSE_CAPACITY + 1)
    else
      count:= populace div (HOUSE_CAPACITY + 1) + 1;
  //�������� ������ ��� ������ �����
    setlength(Self.houselist, count);
  //��������� ���������������� �����
    for i:= 0 to (count-1) do
      Self.houselist[i]:= THouse.create;
  end;

//���������� �� 11.08.2015 - ���������� ������ ������
//���������� ������ ������
  destructor TCity.destroy;
  var
    i: integer;
  begin
  //����� ������������ ������ ����������� ������ ��-��� ������� ����
    for i:=0 to high(Self.houselist) do
      Self.houselist[i].destroy;
    setlength(Self.houselist,0);
    inherited destroy;
  end;

//��������� ��������� �����
  procedure TCity.settle(populace: integer);
  var
    i,j,k: integer; //�������� ������
    rdig: integer; //����� ��� �������� ���������������� ���������� �����
    frspc: byte; //��������� ����� � ��������������� ����
    settled: array of boolean; //������ ��� �������� ������������
    isall,flg: boolean;
  begin
  //���������������� ������� ������������ ������� - �� ��������� ����� �� �������
    setlength(settled, populace);
    for i:= 0 to (populace - 1) do
      settled[i]:= false;
  //���� ��������� ����� - ���������� ���� �� �������, ������� ���� ���������� �����
  //���������� ��������� ����� �� ��� ���, ���� �� ������ ������������� ������
  //� �������� ��� �� ������� ����� � ������� ����. ���� ��� ������ ��� ��������,
  //�� �������� ��������� �����, ������ �� ��� -1
    for j:= 0 to (HOUSE_CAPACITY - 1) do
      for i:= 0 to (length(Self.houselist) - 1) do
      begin
        //���������������� ����� ������������� ��������� (�� ��������� ������)
        isall:= true;
        //���������, ���� �� ������������ ������. ���� ���� ���� �� ����, ������� ������ ������������� ���������
        for k:= 0 to (populace - 1) do
          isall:= isall and settled[k];
        //���� ��������� ���������, �������� � ������� � ���������� ������� ����� -1
        if (isall) then
          Self.houselist[i].people[j]:= -1
        else
        begin
          flg:= false;
          repeat
            rdig:= random(populace); //�������� ���������� ���
          //���� ��������� ��� ��� �� �������, ����� ��� � ������� ����, ��������� ��� � ��������� � ���������� �����
            if (not settled[rdig]) then
            begin
              flg:= true;
              settled[rdig]:= true;
              Self.houselist[i].people[j]:= rdig;
            end;
          until flg;
        end;
      end;
  end;

//��������� ������ ������ � ������ �� �������������� (���������� ����� ���� ��� �� �����, ���� -1, ���� �� �������)
  function TCity.is_settled(numb: integer): integer;
  var
    i,j: integer;
  begin
    result:= -1; //���������������� ����������� ��� "�� �������" (� ������ ���� ������ �� ������, ������� ��� � ������)
    for i:= 0 to high(Self.houselist) do
      for j:= 0 to (HOUSE_CAPACITY - 1) do
      begin
      //���� ������ ������, �������� � ����� ����� ���� � ���������� ����� � ����
        if (Self.houselist[i].people[j] = numb) then
        begin
          result:= i;
          break;
        end;
      //���� ������ ������, ���������� ���������� �����
        if (result <> -1) then
          break;
      end;
  end;
//<-------------------------------------------------------------------------->\\
//<-------------------------------------------------------------------------->\\

//<-------------------------------------------------------------------------->\\
//<----------------------------����� ������� (TPlanet)----------------------->\\
//<-------------------------------------------------------------------------->\\

//����������� ������ �������
  constructor TPlanet.create;
  var
    i,j: Integer;
  begin
    if (Self.store = nil) then
      Self.store:= TStorage.create;
    Self.store.initialize;
  //��������� ���������
    for i:=0 to DISTRICT_SIZE do
      Self.people[i]:= THuman.create(Self.store);
  //���������� �� 19.08.2015
  //������������� ������ � ���������� �������
    Self.housing:= TCity.create(DISTRICT_SIZE + 1); //������������� ������
    Self.housing.settle(DISTRICT_SIZE + 1); //��������������� ���������� ���
  //�������� �������� ��� ���������� � ����� ����������
    for i:= 0 to (length(Self.housing.houselist) - 1) do
      for j:= 0 to (HOUSE_CAPACITY - 1) do
      begin
        Self.people[Self.housing.houselist[i].people[j]].props.address:= i;
      end;
  //���������� �� 01.02.2015
  //����������� ���� �������
    Randomize;
    Self.kind:= Random(ORIGINS_COUNT + 1);
  //���������������� ���������� �� �������� (��������������� ���������)
    for i:=0 to FACTIONS_COUNT do
      Self.factions[i]:=0;
  //������������� ����� �������
    for i:=0 to 2 do
    begin
      if (i = 0) then
        Self.time[i]:= START_YEAR + Random(500); //���
      if (i = 1) then
        Self.time[i]:= Random(12)+1; //�����
      if (i = 2) then
        Self.time[i]:= Random(30) + 1; //����
    end;
  //������������� �������� �������
    Randomize;
    Self.name[1]:= Self.store.data.plnames[Random(10)]; //������������ ����������� ������ �������
    //
    i:= Random(4); //����������� �������� ������, � ������� ��������� ����� ����� (������ infr �� ������������, �.�. �������� �� ����)
    j:= Random(NAMES_COUNT); //����������� ������ ����� ������ �������� ������
    //
    case i of
    0: begin
         if ((random(1001) mod (DICE_D100 + 1)) <= 50) then
            Self.name[0]:= Self.store.data.mnames.prim[j]
         else
            Self.name[0]:= Self.store.data.fnames.prim[j];
       end;
    1: begin
         if ((random(1001) mod (DICE_D100 + 1)) <= 50) then
            Self.name[0]:= Self.store.data.mnames.low[j]
         else
            Self.name[0]:= Self.store.data.fnames.low[j];
       end;
    2: begin
         if ((random(1001) mod (DICE_D100 + 1)) <= 50) then
            Self.name[0]:= Self.store.data.mnames.high[j]
         else
            Self.name[0]:= Self.store.data.fnames.high[j];
       end;
    3: begin
         if ((random(1001) mod (DICE_D100 + 1)) <= 50) then
            Self.name[0]:= Self.store.data.mnames.arch[j]
         else
            Self.name[0]:= Self.store.data.fnames.arch[j];
       end;
    end;
  end;


//��������� ���� ���������
  procedure TPlanet.connect;
  var
    i, k, rndig: Integer;
    j, frees: Byte;
  begin
    Randomize;
  //������� ���� �������
    for i:=0 to DISTRICT_SIZE do
    begin
    //�������� ������� �� ��������� 6 ��������� ������
      for j:=0 to CONTACTS_COUNT do
      begin
      //���� ������� ���� �������� �������� �������� ��� �� ������ ���������
        if (Self.people[i].props.contacts[j] = -1) then
        begin
          repeat
            rndig:= Random(DISTRICT_SIZE); //�������� ���������� ���
            frees:= 0; //������� ��� � ���� ��� ��������� ��� ������ ���������
          //���������� ��� ������ � ������� ���������
            for k:= 0 to CONTACTS_COUNT do
            //������������ ����� ��������� ����� � ����� ���
              if (Self.people[rndig].props.contacts[k] = -1) then
                frees:= frees + 1;
            //���� ����� ��������� ������, ��������� � ��� ����������� ���
            if (frees > 0) then
              Self.people[i].props.contacts[j]:= rndig;
            k:=-1;
            repeat
              k:= k+1;
              //ShowMessage(IntToStr(k));
              if (Self.people[rndig].props.contacts[k] = -1) then
                Self.people[rndig].props.contacts[k]:= i;
            until (Self.people[rndig].props.contacts[k] = i) or (k >= 5);
          until (Self.people[i].props.contacts[j] <> i);
        end;
      end;
    end;
  end;


//��������� ��������� ����������
  procedure TPlanet.GetData;
  var
    i,j: integer;
  begin
  //������������ ���������� - ������������ ���� ��������� �� ������������� �� �������� � ���������� �������� ���� ���� ������� �����������, ������ �������� ��������� � ���� ������� �������� ���
    for i:=0 to DISTRICT_SIZE do
      for j:=0 to FACTIONS_COUNT do
        if (Self.people[i].props.factions[j]) then
          Self.factions[j]:= Self.factions[j] + 1;
  end;

//<-------------------------------------------------------------------------->\\
//<-------------------------------------------------------------------------->\\

end.
