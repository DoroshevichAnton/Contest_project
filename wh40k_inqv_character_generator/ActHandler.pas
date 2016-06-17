//������ ������ ����������� �������� ��� ������� "����������"
//�������� ���������� �.�., 2015

unit ActHandler;

interface

uses
  Windows, SysUtils, Math, Classes, gtl;

type

//����� ����������� ��������
  TActHandler = class
    private
      data: TFactActionData; //���� ������ ��������
    public
      function IsEmpty: Boolean; //
      function SaveData: TFactActionData; //����� ��������������� ������ ��������
      procedure LoadData(data: TFactActionData); //����� �������������� ������ ��������
      constructor NewHandler; overload; //
      constructor NewHandler(data: TFactActionData); overload; //
      destructor KillHandler; overload; //
      destructor KillHandler(expdata: TFactActionData); overload; //
  end;

implementation



end.
