unit String_Insert;

interface

uses
  Classes, SysUtils, Windows;

type

//��� ������ ��������������� �����
  TIntPair = array [0..1] of integer;

//����� ����������� ����� �� ���������
  TInsString = class
    content: String; //������������� ������
    length: integer; //������ ������������� ������
    function SearchInsert(from: integer): TIntPair; //V ������� ������ ����� ������� (���������� ���������� ������ �������)
    function GetInsInfo(coords: TIntPair): integer; //V ������� ��������� ������ �� ������� (��� � ������ ��������� - ���� ����������� ������ ��� ���������) !����������!
    function Insert(ins: String; coords: TIntPair): integer; //V ������� ������� �� ����� (���������� ����� ���������� ����� �������)
    function Count: integer; //V ������� �������� ����� ������� � ������
    procedure TakeIn(cont: String); //V ��������� ��������� ������ ��� ���������
    function GiveOut: String; //V ������� ������ ������� ������ �����
    constructor create; overload; //V ����������� ������ ��� �������� �����������
    constructor create(cont: String); overload; //V ����������� ������ � ��������� �����������
    destructor destroy; overload; //V ���������� ������ � ������������ ����������� �����������
    destructor destroy(outro: String); overload; //V ���������� ������ � ������� ����������� ����������� �����
  end;

const
  INS_OPEN = '{';
  INS_CLOSE = '}';

implementation

//����������� ������ ����������� ����� �� ��������� ��� �������� �������������� ������
  constructor TInsString.create;
  begin
    inherited create;
    Self.content:= ''; //����������������� �������������� ������ ������ �������
    Self.length:= 0; //���������������� ������� �������������� ������ �����
  end;

//����������� ������ ����������� ����� �� ��������� � ��������� �������������� ������ (������� �������� - ����������������� ������ �� ���������)
  constructor TInsString.create(cont: String);
  begin
    inherited create;
  //��������� �������������� ������ � ������ �� �������
    Self.content:= cont;
    Self.length:= lengthS(cont);
  end;

//���������� ������ ����������� ����� �� ��������� � ������������ ����������� �����������
  destructor TInsString.destroy;
  begin
    inherited destroy;
  end;

//���������� ������ ����������� ����� �� ��������� � ��������� ����������� ����������� �����
  destructor TInsString.destroy(outro: String);
  begin
    outro:= Self.content;
    inherited destroy;
  end;

//������� ������ ������� (���������� ���������� ������ � ����� �������)
  function TInsString.SearchInsert(from: integer): TIntPair;
  var
    i: integer;
  begin
  //����� ������ �������
    for i:=1 to Self.length do
    begin
      if (Self.content[i] = INS_OPEN) then
      begin
        result[0]:= i;
        break;
      end;
    end;
  //����� ����� �������
    for i:= (result[0] + 1) to Self.length do
    begin
      if (Self.content[i] = INS_CLOSE) then
      begin
        result[1]:= i;
        break;
      end;
    end;
  end;

//������� ��������� ������ �������
  function TInsString.GetInsInfo(coords: TIntPair): integer;
  var
    tmp: String;
    dif,i: integer;
  begin
    dif:= coords[1] - (coords[0] + 1);
    tmp:= copy(tmp, coords[0] + 1, dif);
    result:= strtoint(tmp);
  end;

//������� �������� ����� �������
  function TInsString.Count: integer;
  var
    i: integer;
  begin
    result:= 0; //���������������� ����������� �������� �����
  //������� ������������ ������������ ��������� ���� ������ � ������� ������������ ������� �������
    for i:= 1 to Self.length do
    begin
      if (Self.content[i] = INS_OPEN) then
        result:= result + 1;
    end;
  end;

//��������� ��������� ������ ��� ���������
  procedure TInsString.TakeIn(cont: string);
  begin
    Self.content:= cont;
    Self.length:= length(cont);
  end;

//������� ������ ��������������� ������ �����
  function TInsString.GiveOut: String;
  begin
    result:= Self.content;
  end;

//������� ������ ����������� ������������������ ��������
  function TInsString.Insert(Ins: String, coords: TIntPair): integer;
  var
    etmp: String;
    btmp: String
  begin
    btmp:= copy(Self.content, 1, coords[0] - 1); //����������� ����� ������ �� ����� �������
    etmp:= copy(Self.content, coords[1] + 1, Self.length - coords[1]); //����������� ����� ������ ����� ������� �� �����
    Self.content:= btmp + Ins + etmp; //�������� ����������� ������������������ ������� �������
    result:= pos(etmp, Self.content); //������������ �������� - ���������� ������ �������� ����� ������ (������������ ��� ������ ������ ��������� �������)
  end;


end.
