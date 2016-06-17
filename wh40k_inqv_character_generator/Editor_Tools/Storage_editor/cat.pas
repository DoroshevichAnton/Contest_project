//������ ������� � ����� ������
unit cat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type

//<-------------------------------------------------------------------------->\\
//<----------------------------- ���� ������ -------------------------------->\\
//<-------------------------------------------------------------------------->\\

//��� ������������ ���������� �������� ��������� (����, ���, ���� ����, ���� ����, ���� �����, 3 ������ �������)
  TOutlook = (ol_bodytype, ol_skin, ol_eyes, ol_hair, ol_perk1, ol_perk2, ol_perk3);

//��� ������������ ����� �������� (������� �������� �������� ������������ ������)
  TActGroups = (ag_force, ag_court, ag_stealth, ag_investigation, ag_others);

//��� ������������ ����� �������� (����� �������� ������� ��������� ������ ������ �����)
  TOrdGroups = (og_kill, og_capture, og_research, og_, og_search, og_freetime);

//��� ������������ ���������� DMS (���������������� ������������ ������������ ����������� ��������������)
  TDMSParams = (dp_diligence, dp_identity, dp_calmness, dp_educability, dp_authority);

//��� ������ ������� �����
  TBytePair = array [0..1] of Byte;

//���������� ��� �� ������
  TSCent = -100..100;

//��� ����� ����
  TNameString = string[60];

//��� �������� ����
  TStrArr = array [0..29] of TNameString;

//��� ��������� ����
  TDialNames = record
    prim: TStrArr;
    low: TStrArr;
    high: TStrArr;
    arch: TStrArr;
    infr: TStrArr;
  end;

//��� ������� ����������� ���
  TAddiction = array [TActGroups] of TSCent;

//��� ������� ���������� DMS
  TDMSArr = array [TDMSParams] of TSCent;

//��� ����� ������������� �����������
  TAddMods = record
    clasmods: array [0..7] of TAddiction; //������������ ������
    factmods: array [0..9] of TAddiction; //������������ �������
    origmods: array [0..3] of TAddiction; //������������ �������������
  end;

//��� ����� ������������� ���������� DMS
  TDMSMods = record
    clasmods: array [0..7] of TDMSArr; //������������ ������
    factmods: array [0..9] of TDMSArr; //������������ �������
    origmods: array [0..3] of TDMSArr; //������������ �������������
  end;

//<-------------------------------------------------------------------------->\\
//<------------------------------- ������ ----------------------------------->\\
//<-------------------------------------------------------------------------->\\

//������������ ����� ������� ��������
  TGameObject = class
    id: Integer; //������������� �������
  end;

//����� ��������� ������
  TStorage = class (TGameObject)
     mnames: TDialNames; //������� �����
     fnames: TDialNames; //������� �����
     cnames: array [0..7] of TNameString; //�������� ��������� (��������� 01.02.2015)
     snames: array [0..8] of TNameString; //�������� ���������� ��������� (��������� 01.02.2015)
     pnames: array [0..8] of TNameString; //�������� ���������� (��������� 01.02.2015)
     plnames: array [0..9] of TNameString; //���������� ������ ������ (��������� 29.05.2015)
     actnames: array [TActGroups] of TNameString; //�������� ����� �������� (��������� 01.07.2015)
     dmsnames: array [TDMSParams] of TNameString; //�������� ���������� DMS (��������� 16.07.2015)
     sbonus: array [0..3, 0..8] of Byte; //������ ���������� �� ������� ���� (��������� 01.02.2015)
     sprobs: array [0..3, 0..7] of Byte; //����������� ��������� � ����������� �� ������������� (��������� 01.02.2015)
     lprobs: array [0..3] of Byte; //����������� ����������� (��������� 01.02.2015)
     factions: array [0..9] of TNameString; //�������� ������� (��������� 01.02.2015)
     fprobs: array [0..9] of Byte; //����������� ���������� �������� (��������� 01.02.2015)
     gender: array [0..2] of TNameString; //�������� �����
     hwtype: array [0..3] of TNameString; //��� ������� ����
     bodytype: array [0..3, 0..4] of TNameString; //��� ������������
     heitype: array [0..3, 0..1, 0..4] of TBytePair; //��� ������ ����/��� (������ ����������: ��� ������� ����, ���, ��������) ������ ����� - ���� (��) ������ ���(��)
     skins: array [0..3, 0..4] of TNameString; //����� ����
     hairs: array [0..3, 0..4] of TNameString; //����� �����
     eyes: array [0..3, 0..4] of TNameString;  //����� ����
     perks: array [0..3, 0..15] of TNameString; //������ ������ ������
     addmods: TAddMods; //��������� ������������� ���������� (��������� 01.07.2015)
     dmsmods: TDMSMods; //��������� ������������� ���������� DMS (��������� 03.07.2015)
     grexe: TNameString; //������ � ����������� ����������� ������ (��������� 05.02.2015)
     procedure initialize;
  end;

//����� �������
  THuman = class(TGameObject)
    name: array [0..2] of TBytePair; //��� (������� �������� ������ � ������ ����� � ������)
    age: Integer; //�������
    address: Integer; //����� ���
    gender: Boolean; //���
    outlook: array [TOutlook] of Byte; //������� ��� ���������
    origin: Byte; //��� ������� ����
    factions: array [0..9] of Boolean; //������ ��������������� � �������� (��������� �� 01.02.2015 - ������� ���� isheretic � ispsyker, ������� ���� factions)
    ladder: array [0..9] of Byte; //��������� ��� ������ ������� (�������, ������������, ��������, ����. ������������ ��������� 3 ��������, �������� - 3 ��������������, ���� - 3 �����������)(��������� 01.02.2015)
    specialty: Byte; //����� ��� (��������� 01.02.2015)
    psychotype: Byte; //�������� (��������� 01.02.2015)
    addictions: TAddiction; //���������� ��� (��������� 01.07.2015)
    dmsparams: TDMSArr; //��������� DMS ��� (��������� 03.07.2015)
    stats: array [0..8] of Byte; //������ ���������� ��� (��������� 01.02.2015)
    contacts: array [0..5] of Integer; //������ ��������� ���
    constructor create (Stock: TStorage); overload;
    destructor destroy; overload;
  end;

//���������� �� 27.07.2015 - ����� ���� (������� ������), ����� ������
//����� ����
  THouse = class(TGameObject)
    people: array [0..9] of integer; //������ ������� ����
    //to-do: ������� ��������� ������ (�����, ���)
    constructor create; overload;
    destructor destroy; overload;
    //to-do: ���������� ������� � ������ �������
  end;

//����� ������
  TCity = class(TGameObject)
    houselist: array of THouse; //������ ����� - ����� ������ ������������ ������������ ���������
    constructor create (populace: integer); overload;
    destructor destroy; overload;
    procedure settle (populace: integer); //��������� ���������� ������� �� �����
    function is_settled (numb: integer): integer; //����� ������ � ������ (���������� -1 ���� ��� ����� �� �����, � ��������� ������ - ����� ����)
    //to-do: ��������� ��������� ������ ������ �� ������
  end;

//����� ������� (����� ������ ���� ������ �������, ����, ������� ����� � �.�.
  TPlanet = class (TGameObject)
    kind: Byte; //������������� ���� ������� (��������� 01.02.2015)
    people: array [0..1000] of THuman; //������ �������
    housing: TCity;
    factions: array [0..9] of Integer; //����������� ������� � �������
    time: array [0..2] of Word; //������ ��������� ������ (���, �����, ����)
    store: TStorage; //����-���������
    name: array [0..1] of TNameString; //�������� �������
    constructor create; overload;
    procedure connect; //��������� ���� ��������� (��������� 05.02.2015)
    procedure GetData; //���� ���������� �� �������
  end;

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
//<--------------------------- ������ ������� ------------------------------->\\
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

//����������� ������ ������
  constructor TCity.create(populace: integer);
  const
    HOUSE_CAPACITY = 10;
  var
    i, count: integer;
  begin
    inherited create;
  //������ ���������� ���������� ����� ��� ������� ��������� ������
  //���� ����������� ������� ������� �� ������� ������ ���� ������ - �������� ����� ������� ����� ������� ���������� ��� �������
  //����� �������� ��� ���� ��� �������������
    if ((populace mod HOUSE_CAPACITY) = 0) then
      count:= populace div HOUSE_CAPACITY
    else
      count:= populace div HOUSE_CAPACITY + 1;
  //�������� ������ ��� ������ �����
    setlength(Self.houselist, count);
  //��������� ���������������� �����
    for i:= 0 to (count-1) do
      Self.houselist[i]:= THouse.create;
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
    for j:= 0 to 9 do
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

//������������� ����-���������
  procedure TStorage.initialize;
  var
    i: Byte;
    rn1: Integer;
  begin
    //������������� �������� �����
    Self.gender[0]:= '�������';
    Self.gender[1]:= '�������';
    Self.gender[2]:= '�������� / �� ����������';

    //������������� ����� ������ �����
    Self.hwtype[0]:= '����� ���';
    Self.hwtype[1]:= '���-����';
    Self.hwtype[2]:= '��������� ���';
    Self.hwtype[3]:= '��������� � �������';

    //��������� �������� �������� ����

    //������������
    //����� ���
    Self.bodytype[0,0]:= '��������';
    Self.bodytype[0,1]:= '�����';
    Self.bodytype[0,2]:= '�����������';
    Self.bodytype[0,3]:= '����������';
    Self.bodytype[0,4]:= '�����������';
    //���-����
    Self.bodytype[1,0]:= '���������';
    Self.bodytype[1,1]:= '���������';
    Self.bodytype[1,2]:= '��������';
    Self.bodytype[1,3]:= '�������';
    Self.bodytype[1,4]:= '�������';
    //��������� ���
    Self.bodytype[2,0]:= '���������';
    Self.bodytype[2,1]:= '��������';
    Self.bodytype[2,2]:= '����������';
    Self.bodytype[2,3]:= '�������';
    Self.bodytype[2,4]:= '���������';
    //��������� � �������
    Self.bodytype[3,0]:= '������';
    Self.bodytype[3,1]:= '������';
    Self.bodytype[3,2]:= '���������';
    Self.bodytype[3,3]:= '���������';
    Self.bodytype[3,4]:= '����������';

    //���� ����
    //����� ���
    Self.skins[0,0]:= '������';
    Self.skins[0,1]:= '���������';
    Self.skins[0,2]:= '�������';
    Self.skins[0,3]:= '�������';
    Self.skins[0,4]:= '���������';
    //���-����
    Self.skins[1,0]:= '������';
    Self.skins[1,1]:= '���������';
    Self.skins[1,2]:= '�������';
    Self.skins[1,3]:= '�������';
    Self.skins[1,4]:= '��������';
    //��������� ���
    Self.skins[2,0]:= '������';
    Self.skins[2,1]:= '���������';
    Self.skins[2,2]:= '�������';
    Self.skins[2,3]:= '�������';
    Self.skins[2,4]:= '��������';
    //��������� � �������
    Self.skins[3,0]:= '����������';
    Self.skins[3,1]:= '�������';
    Self.skins[3,2]:= '�����������';
    Self.skins[3,3]:= '���������';
    Self.skins[3,4]:= '��������';

    //����� �����
    //����� ���
    Self.hairs[0,0]:= '�����';
    Self.hairs[0,1]:= '�������';
    Self.hairs[0,2]:= '�����';
    Self.hairs[0,3]:= '������';
    Self.hairs[0,4]:= '�����';
    //���-����
    Self.hairs[1,0]:= '�����';
    Self.hairs[1,1]:= '�����';
    Self.hairs[1,2]:= '��������';
    Self.hairs[1,3]:= '�����';
    Self.hairs[1,4]:= '������';
    //��������� ���
    Self.hairs[2,0]:= '��������';
    Self.hairs[2,1]:= '�������';
    Self.hairs[2,2]:= '�����';
    Self.hairs[2,3]:= '������';
    Self.hairs[2,4]:= '�����';
    //��������� � �������
    Self.hairs[3,0]:= '���������';
    Self.hairs[3,1]:= '�������';
    Self.hairs[3,2]:= '������';
    Self.hairs[3,3]:= '������';
    Self.hairs[3,4]:= '����������';

    //����� ����
    // ����� ���
    Self.eyes[0,0]:= '�������';
    Self.eyes[0,1]:= '�����';
    Self.eyes[0,2]:= '�����';
    Self.eyes[0,3]:= '�������';
    Self.eyes[0,4]:= '������';
    //���-����
    Self.eyes[1,0]:= '�����';
    Self.eyes[1,1]:= '�����';
    Self.eyes[1,2]:= '�����';
    Self.eyes[1,3]:= '�������';
    Self.eyes[1,4]:= '�����';
    //��������� ���
    Self.eyes[2,0]:= '�������';
    Self.eyes[2,1]:= '�����';
    Self.eyes[2,2]:= '�����';
    Self.eyes[2,3]:= '�������';
    Self.eyes[2,4]:= '�����';
    //��������� � �������
    Self.eyes[3,0]:= '������-�������';
    Self.eyes[3,1]:= '�����';
    Self.eyes[3,2]:= '������';
    Self.eyes[3,3]:= '�������';
    Self.eyes[3,4]:= '����������';

    //��������� ������� ����/���
    //����� ���
    Self.heitype[0,0,0][0]:= 190; Self.heitype[0,0,0][1]:= 65;
    Self.heitype[0,1,0][0]:= 180; Self.heitype[0,1,0][1]:= 60;

    Self.heitype[0,0,1][0]:= 175; Self.heitype[0,0,1][1]:= 60;
    Self.heitype[0,1,1][0]:= 165; Self.heitype[0,1,1][1]:= 55;

    Self.heitype[0,0,2][0]:= 185; Self.heitype[0,0,2][1]:= 85;
    Self.heitype[0,1,2][0]:= 170; Self.heitype[0,1,2][1]:= 70;

    Self.heitype[0,0,3][0]:= 165; Self.heitype[0,0,3][1]:= 80;
    Self.heitype[0,1,3][0]:= 155; Self.heitype[0,1,3][1]:= 70;

    Self.heitype[0,0,4][0]:= 210; Self.heitype[0,0,4][1]:= 200;
    Self.heitype[0,1,4][0]:= 120; Self.heitype[0,1,4][1]:= 100;
    //���-����
    Self.heitype[1,0,0][0]:= 165; Self.heitype[1,0,0][1]:= 45;
    Self.heitype[1,1,0][0]:= 155; Self.heitype[1,1,0][1]:= 40;

    Self.heitype[1,0,1][0]:= 170; Self.heitype[1,0,1][1]:= 55;
    Self.heitype[1,1,1][0]:= 160; Self.heitype[1,1,1][1]:= 50;

    Self.heitype[1,0,2][0]:= 175; Self.heitype[1,0,2][1]:= 65;
    Self.heitype[1,1,2][0]:= 165; Self.heitype[1,1,2][1]:= 55;

    Self.heitype[1,0,3][0]:= 180; Self.heitype[1,0,3][1]:= 65;
    Self.heitype[1,1,3][0]:= 170; Self.heitype[1,1,3][1]:= 60;

    Self.heitype[1,0,4][0]:= 175; Self.heitype[1,0,4][1]:= 80;
    Self.heitype[1,1,4][0]:= 165; Self.heitype[1,1,4][1]:= 75;
    //��������� ���
    Self.heitype[2,0,0][0]:= 175; Self.heitype[2,0,0][1]:= 65;
    Self.heitype[2,1,0][0]:= 165; Self.heitype[2,1,0][1]:= 60;

    Self.heitype[2,0,1][0]:= 185; Self.heitype[2,0,1][1]:= 70;
    Self.heitype[2,1,1][0]:= 175; Self.heitype[2,1,1][1]:= 65;

    Self.heitype[2,0,2][0]:= 175; Self.heitype[2,0,2][1]:= 70;
    Self.heitype[2,1,2][0]:= 165; Self.heitype[2,1,2][1]:= 60;

    Self.heitype[2,0,3][0]:= 190; Self.heitype[2,0,3][1]:= 90;
    Self.heitype[2,1,3][0]:= 180; Self.heitype[2,1,3][1]:= 80;

    Self.heitype[2,0,4][0]:= 180; Self.heitype[2,0,4][1]:= 100;
    Self.heitype[2,1,4][0]:= 170; Self.heitype[2,1,4][1]:= 90;
    //��������� � �������
    Self.heitype[3,0,0][0]:= 175; Self.heitype[3,0,0][1]:= 55;
    Self.heitype[3,1,0][0]:= 170; Self.heitype[3,1,0][1]:= 50;

    Self.heitype[3,0,1][0]:= 165; Self.heitype[3,0,1][1]:= 55;
    Self.heitype[3,1,1][0]:= 155; Self.heitype[3,1,1][1]:= 45;

    Self.heitype[3,0,2][0]:= 185; Self.heitype[3,0,2][1]:= 60;
    Self.heitype[3,1,2][0]:= 175; Self.heitype[3,1,2][1]:= 60;

    Self.heitype[3,0,3][0]:= 200; Self.heitype[3,0,3][1]:= 80;
    Self.heitype[3,1,3][0]:= 185; Self.heitype[3,1,3][1]:= 70;

    Self.heitype[3,0,4][0]:= 210; Self.heitype[3,0,4][1]:= 75;
    Self.heitype[3,1,4][0]:= 195; Self.heitype[3,1,4][1]:= 70;

    //��������� ������� ������ ������
    Self.perks[0,0]:=  '��������� ��������';   Self.perks[1,0]:=  '�������';              Self.perks[2,0]:=  '����������� �����';    Self.perks[3,0]:=  '�������';
    Self.perks[0,1]:=  '��������� �����';      Self.perks[1,1]:=  '�������';              Self.perks[2,1]:=  '������� ���';          Self.perks[3,1]:=  '�����';
    Self.perks[0,2]:=  '������ ���������';     Self.perks[1,2]:=  '����� ��������';       Self.perks[2,2]:=  '���������';            Self.perks[3,2]:=  '������� ������';
    Self.perks[0,3]:=  '������-������';        Self.perks[1,3]:=  '������ ����';          Self.perks[2,3]:=  '�������� ����';        Self.perks[3,3]:=  '��������� ���';
    Self.perks[0,4]:=  '������ ����';          Self.perks[1,4]:=  '�����������������';    Self.perks[2,4]:=  '������� � ����';       Self.perks[3,4]:=  '����� ����������';
    Self.perks[0,5]:=  '��������� �����';      Self.perks[1,5]:=  '�������';              Self.perks[2,5]:=  '������� ���';          Self.perks[3,5]:=  '������ �����';
    Self.perks[0,6]:=  '��������� �����';      Self.perks[1,6]:=  '������������ �������'; Self.perks[2,6]:=  '���������� � �������'; Self.perks[3,6]:=  '������ ����';
    Self.perks[0,7]:=  '���������';            Self.perks[1,7]:=  '����� ������';         Self.perks[2,7]:=  '������� �����';        Self.perks[3,7]:=  '������ ������������� �����';
    Self.perks[0,8]:=  '������ ���';           Self.perks[1,8]:=  '����������';           Self.perks[2,8]:=  '������';               Self.perks[3,8]:=  '������� ������';
    Self.perks[0,9]:=  '������� �����';        Self.perks[1,9]:=  '������� ����';         Self.perks[2,9]:=  '����������� ����';     Self.perks[3,9]:=  '����������� �����������';
    Self.perks[0,10]:= '��������� ����������'; Self.perks[1,10]:= '������� ���';          Self.perks[2,10]:= '�����������������';    Self.perks[3,10]:= '����������';
    Self.perks[0,11]:= '������������';         Self.perks[1,11]:= '������� �����';        Self.perks[2,11]:= '����� � �������';      Self.perks[3,11]:= '���������� ����';
    Self.perks[0,12]:= '�������';              Self.perks[1,12]:= '���������� �����';     Self.perks[2,12]:= '���������� ���';       Self.perks[3,12]:= '��������� ������';
    Self.perks[0,13]:= '������� �����';        Self.perks[1,13]:= '����';                 Self.perks[2,13]:= '������ �����';         Self.perks[3,13]:= '��������';
    Self.perks[0,14]:= '��������� ������';     Self.perks[1,14]:= '��������� ����';       Self.perks[2,14]:= '������';               Self.perks[3,14]:= '������ �������';
    Self.perks[0,15]:= '��������� �������';    Self.perks[1,15]:= '���������� �����';     Self.perks[2,15]:= '��������� �������';    Self.perks[3,15]:= '�������';

    //������������� ������ ������� ����
    with Self.mnames do
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
    with Self.fnames do
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
    Self.cnames[0]:= '�����';    Self.cnames[1]:= '������';
    Self.cnames[2]:= '������';   Self.cnames[3]:= '������';
    Self.cnames[4]:= '��������'; Self.cnames[5]:= '�������';
    Self.cnames[6]:= '�������';  Self.cnames[7]:= '���������';

    //�������� ����������
    Self.snames[0]:= '������� ���';  Self.snames[1]:= '��������';
    Self.snames[2]:= '����';         Self.snames[3]:= '������������';
    Self.snames[4]:= '��������';     Self.snames[5]:= '���������';
    Self.snames[6]:= '����������';   Self.snames[7]:= '���� ����';
    Self.snames[8]:= '������������';

    //������ � ���������� �� ������������� ���
    //����� ���
    Self.sbonus[0,0]:= 20; Self.sbonus[0,1]:= 20;
    Self.sbonus[0,2]:= 25; Self.sbonus[0,3]:= 25;
    Self.sbonus[0,4]:= 20; Self.sbonus[0,5]:= 20;
    Self.sbonus[0,6]:= 20; Self.sbonus[0,7]:= 15;
    Self.sbonus[0,8]:= 15;
    //���-����
    Self.sbonus[1,0]:= 20; Self.sbonus[1,1]:= 20;
    Self.sbonus[1,2]:= 20; Self.sbonus[1,3]:= 15;
    Self.sbonus[1,4]:= 20; Self.sbonus[1,5]:= 20;
    Self.sbonus[1,6]:= 20; Self.sbonus[1,7]:= 20;
    Self.sbonus[1,8]:= 25;
    //��������� ���
    Self.sbonus[2,0]:= 20; Self.sbonus[2,1]:= 20;
    Self.sbonus[2,2]:= 20; Self.sbonus[2,3]:= 20;
    Self.sbonus[2,4]:= 20; Self.sbonus[2,5]:= 20;
    Self.sbonus[2,6]:= 20; Self.sbonus[2,7]:= 20;
    Self.sbonus[2,8]:= 20;
    //�������� � �������
    Self.sbonus[3,0]:= 20; Self.sbonus[3,1]:= 20;
    Self.sbonus[3,2]:= 15; Self.sbonus[3,3]:= 20;
    Self.sbonus[3,4]:= 20; Self.sbonus[3,5]:= 20;
    Self.sbonus[3,6]:= 20; Self.sbonus[3,7]:= 25;
    Self.sbonus[3,8]:= 20;

    //����������� �������������� �� �������������
    //����� ���
    Self.sprobs[0,0]:= 0;  Self.sprobs[0,1]:= 0;  Self.sprobs[0,2]:= 30; Self.sprobs[0,3]:= 0;
    Self.sprobs[0,4]:= 50; Self.sprobs[0,5]:= 10; Self.sprobs[0,6]:= 10; Self.sprobs[0,7]:= 0;
    //���-����
    Self.sprobs[1,0]:= 0;  Self.sprobs[1,1]:= 17; Self.sprobs[1,2]:= 3;  Self.sprobs[1,3]:= 5;
    Self.sprobs[1,4]:= 10; Self.sprobs[1,5]:= 4;  Self.sprobs[1,6]:= 50; Self.sprobs[1,7]:= 11;
    //��������� ���
    Self.sprobs[2,0]:= 12; Self.sprobs[2,1]:= 13; Self.sprobs[2,2]:= 13; Self.sprobs[2,3]:= 14;
    Self.sprobs[2,4]:= 13; Self.sprobs[2,5]:= 14; Self.sprobs[2,6]:= 11; Self.sprobs[2,7]:= 10;
    //��������� � �������
    Self.sprobs[3,0]:= 10; Self.sprobs[3,1]:= 10; Self.sprobs[3,2]:= 5;  Self.sprobs[3,3]:= 10;
    Self.sprobs[3,4]:= 0;  Self.sprobs[3,5]:= 40; Self.sprobs[3,6]:= 10; Self.sprobs[3,7]:= 15;

    //�������� �������
    Self.factions[0]:= '���������';     Self.factions[1]:= '������';
    Self.factions[2]:= '��������';      Self.factions[3]:= '��������� �������';
    Self.factions[4]:= '�������';       Self.factions[5]:= '������������';
    Self.factions[6]:= '���������';     Self.factions[7]:= '���� ������';
    Self.factions[8]:= '���� ��������'; Self.factions[9]:= '���� �������';

    //�������� ����������
    Self.pnames[0]:= '�������';   Self.pnames[1]:= '��������';   Self.pnames[2]:= '�������';
    Self.pnames[3]:= '�����';     Self.pnames[4]:= '����������'; Self.pnames[5]:= '������������';
    Self.pnames[6]:= '���������'; Self.pnames[7]:= '���������';  Self.pnames[8]:= '���������';

    //����������� ��������� ���������� ��������
    Self.fprobs[0]:= 80; Self.fprobs[1]:= 25;
    Self.fprobs[2]:= 18; Self.fprobs[3]:= 30;
    Self.fprobs[4]:= 5;  Self.fprobs[5]:= 15;
    Self.fprobs[6]:= 10; Self.fprobs[7]:= 2;
    Self.fprobs[8]:= 2;  Self.fprobs[9]:= 2;

    //����������� ��������� ����������� (������)
    Self.lprobs[0]:= 67; Self.lprobs[1]:= 7;
    Self.lprobs[2]:= 23; Self.lprobs[3]:= 3;

    //���������� �� 04.02.2015-05.02.2015
    //������ ���������� ����������� ������ (const, ������������ ��� ��������� ������ �� ��������)
    Self.grexe:= '.png';

    //���������� �� 29.05.2015
    //������ �������� ���������� ������� ������
    Self.plnames[0]:= '������';   Self.plnames[1]:= '��������';
    Self.plnames[2]:= '�������';  Self.plnames[3]:= '������';
    Self.plnames[4]:= '������';   Self.plnames[5]:= '�������';
    Self.plnames[6]:= '��������'; Self.plnames[7]:= '�����';
    Self.plnames[8]:= '�����';    Self.plnames[9]:= '�������';

    //���������� �� 01.07.2015
    //������ ������������� �����������

    //������������ ������
    //����� �����
    Self.addmods.clasmods[0][ag_force]:= -20;   Self.addmods.clasmods[0][ag_court]:= 15;
    Self.addmods.clasmods[0][ag_stealth]:= -15; Self.addmods.clasmods[0][ag_investigation]:= 20;
    Self.addmods.clasmods[0][ag_others]:= 0;

    //����� ������
    Self.addmods.clasmods[1][ag_force]:= 15;    Self.addmods.clasmods[1][ag_court]:= -15;
    Self.addmods.clasmods[1][ag_stealth]:= -20; Self.addmods.clasmods[1][ag_investigation]:= 20;
    Self.addmods.clasmods[1][ag_others]:= 0;

    //����� ������
    Self.addmods.clasmods[2][ag_force]:= -15;   Self.addmods.clasmods[2][ag_court]:= -20;
    Self.addmods.clasmods[2][ag_stealth]:= 20;  Self.addmods.clasmods[2][ag_investigation]:= 15;
    Self.addmods.clasmods[2][ag_others]:= 0;

    //����� ������
    Self.addmods.clasmods[3][ag_force]:= -10;   Self.addmods.clasmods[3][ag_court]:= 15;
    Self.addmods.clasmods[3][ag_stealth]:= -15; Self.addmods.clasmods[3][ag_investigation]:= 10;
    Self.addmods.clasmods[3][ag_others]:= 0;

    //����� ��������
    Self.addmods.clasmods[4][ag_force]:= 20;    Self.addmods.clasmods[4][ag_court]:= -20;
    Self.addmods.clasmods[4][ag_stealth]:= 15;  Self.addmods.clasmods[4][ag_investigation]:= -15;
    Self.addmods.clasmods[4][ag_others]:= 0;

    //����� �������
    Self.addmods.clasmods[5][ag_force]:= -20;   Self.addmods.clasmods[5][ag_court]:= -15;
    Self.addmods.clasmods[5][ag_stealth]:= 15;  Self.addmods.clasmods[5][ag_investigation]:= 20;
    Self.addmods.clasmods[5][ag_others]:= 0;

    //����� �������
    Self.addmods.clasmods[6][ag_force]:= 15;    Self.addmods.clasmods[6][ag_court]:= -15;
    Self.addmods.clasmods[6][ag_stealth]:= 20;  Self.addmods.clasmods[6][ag_investigation]:= -20;
    Self.addmods.clasmods[6][ag_others]:= 0;

    //����� ���������
    Self.addmods.clasmods[7][ag_force]:= 15;    Self.addmods.clasmods[7][ag_court]:= -15;
    Self.addmods.clasmods[7][ag_stealth]:= -20; Self.addmods.clasmods[7][ag_investigation]:= 20;
    Self.addmods.clasmods[7][ag_others]:= 0;

    //������������ �������������
    //������������� ����� ���
    Self.addmods.origmods[0][ag_force]:= 20;    Self.addmods.origmods[0][ag_court]:= -20;
    Self.addmods.origmods[0][ag_stealth]:= 10;  Self.addmods.origmods[0][ag_investigation]:= -10;
    Self.addmods.origmods[0][ag_others]:= 0;

    //������������� ���-����
    Self.addmods.origmods[1][ag_force]:= -10;   Self.addmods.origmods[1][ag_court]:= 15;
    Self.addmods.origmods[1][ag_stealth]:= 15;  Self.addmods.origmods[1][ag_investigation]:= 10;
    Self.addmods.origmods[1][ag_others]:= 0;

    //������������� ��������� ���
    Self.addmods.origmods[2][ag_force]:= 10;    Self.addmods.origmods[2][ag_court]:= 20;
    Self.addmods.origmods[2][ag_stealth]:= -20; Self.addmods.origmods[2][ag_investigation]:= -10;
    Self.addmods.origmods[2][ag_others]:= 0;

    //������������� �������
    Self.addmods.origmods[3][ag_force]:= -20;   Self.addmods.origmods[3][ag_court]:= -10;
    Self.addmods.origmods[3][ag_stealth]:= 10;  Self.addmods.origmods[3][ag_investigation]:= 20;
    Self.addmods.origmods[3][ag_others]:= 0;

    //������������ �������
    //������� ��������
    Self.addmods.factmods[0][ag_force]:= -10;   Self.addmods.factmods[0][ag_court]:= 10;
    Self.addmods.factmods[0][ag_stealth]:= 10;  Self.addmods.factmods[0][ag_investigation]:= -10;
    Self.addmods.factmods[0][ag_others]:= 0;

    //������� �������
    Self.addmods.factmods[1][ag_force]:= 15;    Self.addmods.factmods[1][ag_court]:= -15;
    Self.addmods.factmods[1][ag_stealth]:= 15;  Self.addmods.factmods[1][ag_investigation]:= -15;
    Self.addmods.factmods[1][ag_others]:= 0;

    //������� ��������
    Self.addmods.factmods[2][ag_force]:= 15;    Self.addmods.factmods[2][ag_court]:= -15;
    Self.addmods.factmods[2][ag_stealth]:= -20; Self.addmods.factmods[2][ag_investigation]:= 20;
    Self.addmods.factmods[2][ag_others]:= 0;

    //������� ��������� �������
    Self.addmods.factmods[3][ag_force]:= 20;    Self.addmods.factmods[3][ag_court]:= -20;
    Self.addmods.factmods[3][ag_stealth]:= 10;  Self.addmods.factmods[3][ag_investigation]:= -10;
    Self.addmods.factmods[3][ag_others]:= 0;

    //������� �������
    Self.addmods.factmods[4][ag_force]:= 0;     Self.addmods.factmods[4][ag_court]:= 0;
    Self.addmods.factmods[4][ag_stealth]:= 0;   Self.addmods.factmods[4][ag_investigation]:= 0;
    Self.addmods.factmods[4][ag_others]:= 0;

    //������� ������������
    Self.addmods.factmods[5][ag_force]:= -10;   Self.addmods.factmods[5][ag_court]:= 20;
    Self.addmods.factmods[5][ag_stealth]:= -20; Self.addmods.factmods[5][ag_investigation]:= 10;
    Self.addmods.factmods[5][ag_others]:= 0;

    //������� ���������
    Self.addmods.factmods[6][ag_force]:= 15;    Self.addmods.factmods[6][ag_court]:= -15;
    Self.addmods.factmods[6][ag_stealth]:= -20; Self.addmods.factmods[6][ag_investigation]:= 20;
    Self.addmods.factmods[6][ag_others]:= 0;

    //������� ���� ������
    Self.addmods.factmods[7][ag_force]:= 0;     Self.addmods.factmods[7][ag_court]:= 0;
    Self.addmods.factmods[7][ag_stealth]:= 0;   Self.addmods.factmods[7][ag_investigation]:= 0;
    Self.addmods.factmods[7][ag_others]:= 0;

    //������� ���� ��������
    Self.addmods.factmods[8][ag_force]:= 0;     Self.addmods.factmods[8][ag_court]:= 0;
    Self.addmods.factmods[8][ag_stealth]:= 0;   Self.addmods.factmods[8][ag_investigation]:= 0;
    Self.addmods.factmods[8][ag_others]:= 0;

    //������� ���� �������
    Self.addmods.factmods[9][ag_force]:= 0;     Self.addmods.factmods[9][ag_court]:= 0;
    Self.addmods.factmods[9][ag_stealth]:= 0;   Self.addmods.factmods[9][ag_investigation]:= 0;
    Self.addmods.factmods[9][ag_others]:= 0;

    //���������� �� 03.07.2015
    //������������ ���������� DMS

    //������������ ������
    //����� �����
    Self.dmsmods.clasmods[0][dp_diligence]:= 20; Self.dmsmods.clasmods[0][dp_identity]:= 20;
    Self.dmsmods.clasmods[0][dp_calmness]:= 0;  Self.dmsmods.clasmods[0][dp_educability]:= 20;
    Self.dmsmods.clasmods[0][dp_authority]:= 10;

    //����� ������
    Self.dmsmods.clasmods[1][dp_diligence]:= 20; Self.dmsmods.clasmods[1][dp_identity]:= 10;
    Self.dmsmods.clasmods[1][dp_calmness]:= 20;  Self.dmsmods.clasmods[1][dp_educability]:= 0;
    Self.dmsmods.clasmods[1][dp_authority]:= 15;

    //����� ������
    Self.dmsmods.clasmods[2][dp_diligence]:= 5; Self.dmsmods.clasmods[2][dp_identity]:= 20;
    Self.dmsmods.clasmods[2][dp_calmness]:= 20;  Self.dmsmods.clasmods[2][dp_educability]:= 0;
    Self.dmsmods.clasmods[2][dp_authority]:= -10;

    //����� ������
    Self.dmsmods.clasmods[3][dp_diligence]:= 20; Self.dmsmods.clasmods[3][dp_identity]:= -10;
    Self.dmsmods.clasmods[3][dp_calmness]:= 10;  Self.dmsmods.clasmods[3][dp_educability]:= -10;
    Self.dmsmods.clasmods[3][dp_authority]:= 20;

    //����� ��������
    Self.dmsmods.clasmods[4][dp_diligence]:= 20; Self.dmsmods.clasmods[4][dp_identity]:= 10;
    Self.dmsmods.clasmods[4][dp_calmness]:= 20;  Self.dmsmods.clasmods[4][dp_educability]:= 0;
    Self.dmsmods.clasmods[4][dp_authority]:= 0;

    //����� �������
    Self.dmsmods.clasmods[5][dp_diligence]:= 10; Self.dmsmods.clasmods[5][dp_identity]:= 15;
    Self.dmsmods.clasmods[5][dp_calmness]:= 10;  Self.dmsmods.clasmods[5][dp_educability]:= 15;
    Self.dmsmods.clasmods[5][dp_authority]:= -20;

    //����� �������
    Self.dmsmods.clasmods[6][dp_diligence]:= -20; Self.dmsmods.clasmods[6][dp_identity]:= -15;
    Self.dmsmods.clasmods[6][dp_calmness]:= 10;  Self.dmsmods.clasmods[6][dp_educability]:= -10;
    Self.dmsmods.clasmods[6][dp_authority]:= 0;

    //����� ���������
    Self.dmsmods.clasmods[7][dp_diligence]:= 10; Self.dmsmods.clasmods[7][dp_identity]:= 20;
    Self.dmsmods.clasmods[7][dp_calmness]:= 20;  Self.dmsmods.clasmods[7][dp_educability]:= 20;
    Self.dmsmods.clasmods[7][dp_authority]:= 10;

    //������������ �������������
    //������������� ����� ���
    Self.dmsmods.origmods[0][dp_diligence]:= 20; Self.dmsmods.origmods[0][dp_identity]:= 10;
    Self.dmsmods.origmods[0][dp_calmness]:= 10;  Self.dmsmods.origmods[0][dp_educability]:= -10;
    Self.dmsmods.origmods[0][dp_authority]:= -10;

    //������������� ���-����
    Self.dmsmods.origmods[1][dp_diligence]:= -15; Self.dmsmods.origmods[1][dp_identity]:= -10;
    Self.dmsmods.origmods[1][dp_calmness]:= 10;  Self.dmsmods.origmods[1][dp_educability]:= 15;
    Self.dmsmods.origmods[1][dp_authority]:= 10;

    //������������� ��������� ���
    Self.dmsmods.origmods[2][dp_diligence]:= 10; Self.dmsmods.origmods[2][dp_identity]:= -5;
    Self.dmsmods.origmods[2][dp_calmness]:= 5;  Self.dmsmods.origmods[2][dp_educability]:= 5;
    Self.dmsmods.origmods[2][dp_authority]:= 15;

    //������������� �������
    Self.dmsmods.origmods[3][dp_diligence]:= -5; Self.dmsmods.origmods[3][dp_identity]:= 20;
    Self.dmsmods.origmods[3][dp_calmness]:= 15;  Self.dmsmods.origmods[3][dp_educability]:= 20;
    Self.dmsmods.origmods[3][dp_authority]:= -15;

    //������������ �������
    //������� ��������
    Self.dmsmods.factmods[0][dp_diligence]:= 10; Self.dmsmods.factmods[0][dp_identity]:= -20;
    Self.dmsmods.factmods[0][dp_calmness]:= -20;  Self.dmsmods.factmods[0][dp_educability]:= 0;
    Self.dmsmods.factmods[0][dp_authority]:= 0;

    //������� �������
    Self.dmsmods.factmods[1][dp_diligence]:= -20; Self.dmsmods.factmods[1][dp_identity]:= -15;
    Self.dmsmods.factmods[1][dp_calmness]:= 5;  Self.dmsmods.factmods[1][dp_educability]:= -5;
    Self.dmsmods.factmods[1][dp_authority]:= -5;

    //������� ��������
    Self.dmsmods.factmods[2][dp_diligence]:= 20; Self.dmsmods.factmods[2][dp_identity]:= 10;
    Self.dmsmods.factmods[2][dp_calmness]:= 10;  Self.dmsmods.factmods[2][dp_educability]:= 5;
    Self.dmsmods.factmods[2][dp_authority]:= 15;

    //������� ��������� �������
    Self.dmsmods.factmods[3][dp_diligence]:= 20; Self.dmsmods.factmods[3][dp_identity]:= 10;
    Self.dmsmods.factmods[3][dp_calmness]:= 15;  Self.dmsmods.factmods[3][dp_educability]:= 5;
    Self.dmsmods.factmods[3][dp_authority]:= 10;

    //������� �������
    Self.dmsmods.factmods[4][dp_diligence]:= 0; Self.dmsmods.factmods[4][dp_identity]:= 0;
    Self.dmsmods.factmods[4][dp_calmness]:= 0;  Self.dmsmods.factmods[4][dp_educability]:= 0;
    Self.dmsmods.factmods[4][dp_authority]:= 0;

    //������� ������������
    Self.dmsmods.factmods[5][dp_diligence]:= 20; Self.dmsmods.factmods[5][dp_identity]:= -10;
    Self.dmsmods.factmods[5][dp_calmness]:= -5;  Self.dmsmods.factmods[5][dp_educability]:= -10;
    Self.dmsmods.factmods[5][dp_authority]:= 20;

    //������� ���������
    Self.dmsmods.factmods[6][dp_diligence]:= 5; Self.dmsmods.factmods[6][dp_identity]:= 20;
    Self.dmsmods.factmods[6][dp_calmness]:= 20;  Self.dmsmods.factmods[6][dp_educability]:= 20;
    Self.dmsmods.factmods[6][dp_authority]:= 15;

    //������� ���� ������
    Self.dmsmods.factmods[7][dp_diligence]:= 20; Self.dmsmods.factmods[7][dp_identity]:= 15;
    Self.dmsmods.factmods[7][dp_calmness]:= 20;  Self.dmsmods.factmods[7][dp_educability]:= 15;
    Self.dmsmods.factmods[7][dp_authority]:= 20;

    //������� ���� ��������
    Self.dmsmods.factmods[8][dp_diligence]:= 20; Self.dmsmods.factmods[8][dp_identity]:= 15;
    Self.dmsmods.factmods[8][dp_calmness]:= 20;  Self.dmsmods.factmods[8][dp_educability]:= 15;
    Self.dmsmods.factmods[8][dp_authority]:= 20;

    //������� ���� �������
    Self.dmsmods.factmods[9][dp_diligence]:= 20; Self.dmsmods.factmods[9][dp_identity]:= 15;
    Self.dmsmods.factmods[9][dp_calmness]:= 20;  Self.dmsmods.factmods[9][dp_educability]:= 15;
    Self.dmsmods.factmods[9][dp_authority]:= 20;

    //������ �������� ����� ��������
    Self.actnames[ag_force]:='�������';    Self.actnames[ag_court]:='��������';
    Self.actnames[ag_stealth]:='��������'; Self.actnames[ag_investigation]:='������������';
    Self.actnames[ag_others]:='������';

    //���������� �� 16.07.2015
    //������ �������� ���������� DMS
    Self.dmsnames[dp_diligence]:= '����������������'; Self.dmsnames[dp_identity]:= '������������';
    Self.dmsnames[dp_calmness]:= '������������';      Self.dmsnames[dp_educability]:= '�����������';
    Self.dmsnames[dp_authority]:= '��������������';
  end;

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
    Self.gender:= (((Random(2)+1) div 2) = 0);
    //������������� ������ ��� ��� ������� (��� ��� ������ �� �������)
    Self.address:= -1;
    //��������� ���� ������� ����
    Self.origin:= Random(4);
    //����������� ����� �� 3 ���� (��������, ����������� �� �������� ������ � ����� ����� ������ ������)
    for i:=0 to 2 do
    begin
      Self.name[i][0]:= Random(4); //����������� �������� ������, � ������� ��������� ����� ����� (������ infr �� ������������, �.�. �������� �� ����)
      Self.name[i][1]:= Random(30); //����������� ������ ����� ������ �������� ������
    end;
    //��������� ���������
    //������������
    Self.outlook[ol_bodytype]:= Random(5);
    //���� ����
    Self.outlook[ol_skin]:= Random(5);
    //���� ����
    Self.outlook[ol_eyes]:= Random(5);
    //���� �����
    Self.outlook[ol_hair]:= Random(5);
    //������ �������
    Self.outlook[ol_perk1]:= Random(16);
    repeat
      Self.outlook[ol_perk2]:= Random(16);
    until (Self.outlook[ol_perk2]<>Self.outlook[ol_perk1]);
    repeat
      Self.outlook[ol_perk3]:= Random(16);
    until ((Self.outlook[ol_perk3]<>Self.outlook[ol_perk1])and(Self.outlook[ol_perk3]<>Self.outlook[ol_perk2]));
    //��������� ��������
    Self.age:= genrnd(25+Random(30), 20+Random(20));
    //���������� � ��������� �� 01.02.2015
    //������ ��������� ������� ������� � ��������, ��������� ��������� �������������� � ���������� �������
    //������� ��������: 1-3)�������� ������-��������-������� (�.�. ����� ����������� �����������)
    //4)������� 5)��������� 6)������������ 7)�������� 8)������� 9)������� 10)���������
    //������ �������� ��������� - �������� ���� �� ���������� ����������� ��� ��������� ������ �������� (������������� ������������ ��������)
    //���������������� ���������� �������� (��������� �������� - ����)�
    for i:= 0 to 9 do
      Self.factions[i]:= False;
    //�������� �� �������������� � ���� ������� (��� �� ������ ������������ � ��������, ���� ������ � ���� ��������)
    if (Random(101) <= Stock.fprobs[9]) then
      Self.factions[9]:= True;
    //�������� �� �������������� � ���� �������� (��� �� ������ ������������ � ���� �������)
    if (Random(101) <= Stock.fprobs[8]) and (Self.factions[9] = False) then
      Self.factions[8]:= True;
    //�������� �� �������������� � ���� ������ (��� �� ������ ������������ � ���� ������� � ���� ��������)
    if (Random(101) <= Stock.fprobs[7]) and (Self.factions[9] = False) and (Self.factions[8] = False) then
      Self.factions[7]:= True;
    //�������� �� �������������� � �������� (��� �� ������ ������������ � ���� ������, ���� ��������, ���� �������)
    if (Random(101) <= Stock.fprobs[4]) and (Self.factions[9] = False) and (Self.factions[8] = False) and (Self.factions[7] = False) then
      Self.factions[4]:= True;
    //�������� �� �������������� � ���������
    if (Random(101) <= Stock.fprobs[6]) then
      Self.factions[6]:= True;
    //�������� �� �������������� � ������������ (��� �� ������ ������������ � ���������)
    if (Random(101) <= Stock.fprobs[5]) and (Self.factions[6] = False) then
      Self.factions[5]:= True;
    //�������� �� �������������� � �������� (��� �� ������ ������������ � ������������ � ���������)
    if (Random(101) <= Stock.fprobs[2]) and (Self.factions[6] = False) and (Self.factions[5] = False) then
      Self.factions[2]:= True;
    //�������� �� �������������� � �������� (��� �� ������ ������������ � ��������, ������������ � ���������)
    if (Random(101) <= Stock.fprobs[1]) and (Self.factions[6] = False) and (Self.factions[5] = False) and (Self.factions[2] = False) then
      Self.factions[1]:= True;
    //�������� �� �������������� � ������� (��� �� ������ ������������ � �������� � ��������)
    if (Random(101) <= Stock.fprobs[3]) and (Self.factions[1] = False) and (Self.factions[2] = False) then
      Self.factions[3]:= True;
    //�������� �� �������������� � ��������� (��� �� ������ ������������ � ��������, �������, ������������ � ���������)
    if (Self.factions[2] = False) and (Self.factions[3] = False) and (Self.factions[5] = False) and (Self.factions[6] = False) then
      Self.factions[0]:= True;
    //��������� ���������� ��������� �� ��������� ��� = ���(20) + ���, ���: ��� - �������� �������� ���������, ��� - ������� ��������� ���������� ����� �� 1 �� 20, ��� - ����� ������� ����
    for i:=0 to 8 do
      Self.stats[i]:= (Random(20) + 2) + Stock.sbonus[Self.origin, i];
    //��������
    Self.psychotype:= Random(89) div 10; // ����������� ��������� ���
    //����������� ������������� ���
    Self.specialty:= 8; //���������������� �������������� ������������� (������������� ��������������� ��� �������� ������������ ��������� - 0..7)
    i:= 0; //������������� �������� ��� �������� ��������������
    k:= 0;
    repeat
      if (i>7) then i:= 0; //���� �������� �������� �������� (0..7) �� ������� ������� � ������
      //���� ��������� ����� ������������ � �������� (0..�), ��� � - ����������� ������������� ��� ������� ���� ������� ����, ��������� ��������� ��� �������������
      if((Random(100)+1) <= Stock.sprobs[Self.origin,i]) then
        Self.specialty:= i;
      i:= i+1; //�������� ������� �� ���� �������
      k:= k+1; //������� �������� (��� ���������� ������
    until (Self.specialty < 8) or (k >= 100); //������� ������ �� ����� - ��������� �������������� ������������� � �������� 0..7 ���� ������� 100 ��������������� ��������
    //��������� ������ � �������, � ������� �� �������
    for i:=0 to 9 do
    //���� ��� ����������� � �������, ������ ��������� ������
      if (Self.factions[i]) then
      begin
        Self.ladder[i]:=4; //���������������� ������ ��� �������� ���������� (0..3)
        j:= 0; //��������� �������� �� ����
        k:= 0;
        repeat
          if (j > 3) then j:= 0; //���� ������� ����� �� �������� ���������, ������� ��� � ������
          //���� ��������� ����� �� 0 �� 100 ����� � ��������� 0..�, ��� � - ����������� ������, ���������� �������� ���� ������ �������� �������� ��������
          if (Random(101) <= Stock.lprobs[j]) then
            Self.ladder[i]:= j;
          j:= j + 1;
          k:= k + 1;
        until (Self.ladder[i] < 4) or (k >= 100);
      end;
    //���������� �� 14.07.2015
    //������������� �������� ���������� DMS � �����������
    //������ �����������
    //���������������� ������� �����������
      for ag:= ag_force to ag_others do
      begin
        Self.addictions[ag]:= Random(81) - 40; //������ �������� ������� ����������� ���������������� ��������� ������ -40..40
      end;
    //���������� ������������� � ������� �����������
      for ag:= ag_force to ag_others do
      begin
      //����������� ������
        Self.addictions[ag]:= Self.addictions[ag] + Stock.addmods.clasmods[Self.specialty][ag];
      //����������� �������������
        Self.addictions[ag]:= Self.addictions[ag] + Stock.addmods.origmods[Self.origin][ag];
      //������������ �������
      //����������������
        factsum:= 0;
      //������ ���������� ������������ �� �������� ��������� DMS
        for i:= 0 to 9 do
        begin
        //����������� ������ ������������ �������, � ������� ����������� ���
          if Self.factions[i] then
          begin
            factsum:= factsum + Stock.addmods.factmods[i][ag];
          //���� ����� ����� �� �������, ������� � ���������� ��������
            if (factsum < -20) then
              factsum:= -20;
            if (factsum > 20) then
              factsum:= 20;
          end;
        end;
      //���������� ���������� ������������ �������
        Self.addictions[ag]:= Self.addictions[ag] + factsum;
      end;
    //������ ���������� DMS
    //���������������� ������� ���������� DMS ���
      for dp:= dp_diligence to dp_authority do
      begin
        Self.dmsparams[dp]:= Random(81) - 40; //������ �������� DMS ��� ���������������� ��� ��������� ����� -40..40
      end;
    //���������� ������������� ���������� DMS
      for dp:= dp_diligence to dp_authority do
      begin
      //����������� ������
        Self.dmsparams[dp]:= Self.dmsparams[dp] + Stock.dmsmods.clasmods[Self.specialty][dp];
      //������������ �������������
        Self.dmsparams[dp]:= Self.dmsparams[dp] + Stock.dmsmods.origmods[Self.origin][dp];
      //������������ �������
      //����������������
        factsum:= 0;
      //������ ���������� ������������ �� �������� ��������� DMS
        for i:= 0 to 9 do
        begin
        //����������� ������ ������������ �������, � ������� ����������� ���
          if Self.factions[i] then
          begin
            factsum:= factsum + Stock.dmsmods.factmods[i][dp];
          //���� ����� ����� �� �������, ������� � ���������� ��������
            if (factsum < -20) then
              factsum:= -20;
            if (factsum > 20) then
              factsum:= 20;
          end;
        end;
      //���������� ���������� ������������ DMS
        Self.dmsparams[dp]:= Self.dmsparams[dp] + factsum;
      end;
    //���������� �� 04.02.2015-05.02.2015
    //���������������� ������� ���������
    for i:=0 to 5 do
      Self.contacts[i]:= -1; //��� ������� ��������������� � -1 (��� �������� ���������)
    //�������������� �������� � 1 �� ��� ���������� ������ ���������� ��������� �����
    Sleep(1);
  end;

//����������� ������ �������
  constructor TPlanet.create;
  var
    i,j: Integer;
  begin
  //������������� � ���������� ����-���������
    if (Self.store = nil) then
      Self.store:= TStorage.create;
    Self.store.initialize;
  //���������� �� 17.08.2015
  //������������� ������ � ���������� ��� �� �����
    if (Self.housing = nil) then
      Self.housing:= TCity.create(1001);
    Self.housing.settle(1001);
  //��������� ���������
    for i:=0 to 1000 do
      Self.people[i]:= THuman.create(Self.store);
  //���������� �� 17.08.2015
  //������� ��� ������� � ������
    for i:= 0 to high(Self.housing.houselist) do
      for j:= 0 to (HOUSE_CAPACITY - 1) do
      begin
        Self.people[Self.housing.houselist[i].people[j]]:= i;
      end;
  //���������� �� 01.02.2015
  //����������� ���� �������
    Randomize;
    Self.kind:= Random(4);
  //���������������� ���������� �� �������� (��������������� ���������)
    for i:=0 to 9 do
      Self.factions[i]:=0;
  //������������� ����� �������
    for i:=0 to 2 do
    begin
      if (i = 0) then
        Self.time[i]:= 40000 + Random(500); //���
      if (i = 1) then
        Self.time[i]:= Random(12)+1; //�����
      if (i = 2) then
        Self.time[i]:= Random(30) + 1; //����
    end;
  //������������� �������� �������
    Randomize;
    Self.name[1]:= Self.store.plnames[Random(10)]; //������������ ����������� ������ �������
    //
    i:= Random(4); //����������� �������� ������, � ������� ��������� ����� ����� (������ infr �� ������������, �.�. �������� �� ����)
    j:= Random(30); //����������� ������ ����� ������ �������� ������
    //
    case i of
    0: begin
         if ((random(1001) mod 101) <= 50) then
            Self.name[0]:= Self.store.mnames.prim[j]
         else
            Self.name[0]:= Self.store.fnames.prim[j];
       end;
    1: begin
         if ((random(1001) mod 101) <= 50) then
            Self.name[0]:= Self.store.mnames.low[j]
         else
            Self.name[0]:= Self.store.fnames.low[j];
       end;
    2: begin
         if ((random(1001) mod 101) <= 50) then
            Self.name[0]:= Self.store.mnames.high[j]
         else
            Self.name[0]:= Self.store.fnames.high[j];
       end;
    3: begin
         if ((random(1001) mod 101) <= 50) then
            Self.name[0]:= Self.store.mnames.arch[j]
         else
            Self.name[0]:= Self.store.fnames.arch[j];
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
    for i:=0 to 1000 do
    begin
      for j:=0 to 5 do
      begin
        if (Self.people[i].contacts[j] = -1) then
        begin
          repeat
            rndig:= Random(1001);
            frees:= 0;
            for k:= 0 to 5 do
              if (Self.people[rndig].contacts[k] = -1) then
                frees:= frees + 1;
            if (frees > 0) then
              Self.people[i].contacts[j]:= rndig;
            k:=-1;
            repeat
              k:= k+1;
              //ShowMessage(IntToStr(k));
              if (Self.people[rndig].contacts[k] = -1) then
                Self.people[rndig].contacts[k]:= i;
            until (Self.people[rndig].contacts[k] = i) or (k >= 5);
          until (Self.people[i].contacts[j] <> i);
        end;
      end;
    end;
  end;


//���������� ���
  destructor THuman.destroy;
  begin
    inherited destroy;
  end;

//��������� ��������� ����������
  procedure TPlanet.GetData;
  var
    i,j: integer;
  begin
  //������������ ���������� - ������������ ���� ��������� �� ������������� �� �������� � ���������� �������� ���� ���� ������� �����������, ������ �������� ��������� � ���� ������� �������� ���
    for i:=0 to 1000 do
      for j:=0 to 9 do
        if (Self.people[i].factions[j]) then
          Self.factions[j]:= Self.factions[j] + 1;
  end;


end.
