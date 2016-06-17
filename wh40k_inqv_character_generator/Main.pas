unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, cat, gtl;

type

//����� ���� ���������
  TfrmMain = class(TForm)
    lstPeopleList: TListBox;
    mmoPerson: TMemo;
    lblPersonAbout: TLabel;
    btnExit: TButton;
    imgPortrait: TImage;
    lblPlanet: TLabel;
    lbledtYear: TLabeledEdit;
    lbledtMonth: TLabeledEdit;
    lbledtDay: TLabeledEdit;
    imgPlanet: TImage;
    lblPlanetInfo: TLabel;
    mmoPlanetInfo: TMemo;
    btnTurn: TButton;
    lblEventInfo: TLabel;
    mmoEventList: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure lstPeopleListClick(Sender: TObject);
    procedure btnTurnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LogName: string; //��� ����� ���� ������
  end;

var
  frmMain: TfrmMain;
  Planet: TPlanet; //���� ��������


implementation

{$R *.dfm}

//�������� ���� ���������
  procedure TfrmMain.FormCreate(Sender: TObject);
  var
    i: Integer;
    j: Byte;
    s: string;
  begin
    Planet:= TPlanet.create;
    Planet.connect;
    Planet.GetData;
    for i:=0 to DISTRICT_SIZE do
    begin
      if (i < 10)then
        s:= IntToStr(i) + '      ';
      if (i >= 10) and (i < 100) then
        s:= IntToStr(i) + '    ';
      if (i >= 100) then
        s:= IntToStr(i) + '  ';
      for j:=0 to 2 do
      begin
        if (j <> 1) then
        case Planet.people[i].props.name[j][0] of
          0: begin
               if (Planet.people[i].props.gender) then
               begin
                 s:= s + Planet.store.data.mnames.prim[Planet.people[i].props.name[j][1]]+' ';
                end
               else
               begin
                 s:= s + Planet.store.data.fnames.prim[Planet.people[i].props.name[j][1]]+' ';
               end;
              end;
          1: begin
               if (Planet.people[i].props.gender) then
               begin
                 s:= s + Planet.store.data.mnames.low[Planet.people[i].props.name[j][1]]+' ';
               end
               else
               begin
                 s:= s + Planet.store.data.fnames.low[Planet.people[i].props.name[j][1]]+' ';
               end;
             end;
          2: begin
               if (Planet.people[i].props.gender) then
               begin
                 s:= s + Planet.store.data.mnames.high[Planet.people[i].props.name[j][1]]+' ';
               end
               else
               begin
                 s:= s + Planet.store.data.fnames.high[Planet.people[i].props.name[j][1]]+' ';
               end;
             end;
          3: begin
               if (Planet.people[i].props.gender) then
               begin
                 s:= s + Planet.store.data.mnames.arch[Planet.people[i].props.name[j][1]]+' ';
               end
               else
               begin
                 s:= s + Planet.store.data.fnames.arch[Planet.people[i].props.name[j][1]]+' ';
               end;
             end;
        end;
      end;
      lstPeopleList.Items.Add(s);
    end;
  //���������� �� �������
    mmoPlanetInfo.Lines.Add('��������: ' + Planet.name[0] +' '+ Planet.name[1]);
    s:= '��� ���� (�� ����������� ��������� �������������): ';
    s:= s + Planet.store.data.hwtype[Planet.kind];
    mmoPlanetInfo.Lines.Add(s);
    mmoPlanetInfo.Lines.Add('-------------------------------------------------------');
    s:= '����������� ������� �� �������: ';
    mmoPlanetInfo.Lines.Add(s);
    for i:=0 to 9 do
      mmoPlanetInfo.Lines.Add(Planet.store.data.factions[i]+': '+IntToStr(Planet.factions[i]));
  //��������� � ���������� �� 09.02.2015
  //������� ����������� �������� ���������������� ���������� ������� �������
  //���������� ����� ������ ������� ��� ���������
    lbledtYear.Enabled:= False;
    lbledtMonth.Enabled:= False;
    lbledtDay.Enabled:= False;
  //����� ������� � ����    
    lbledtYear.Text:= IntToStr(Planet.time[0]);
    lbledtMonth.Text:= IntToStr(Planet.time[1]);
    lbledtDay.Text:= IntToStr(Planet.time[2]);
  end;

//��������� ���������� �� �������

//����� �� ���������
  procedure TfrmMain.btnExitClick(Sender: TObject);
  var
    i: Integer;
  begin
    Planet.store.Destroy;
    for i:=0 to DISTRICT_SIZE do
      Planet.people[i].destroy;
    Planet.Destroy;
    frmMain.Close;
  end;

//����� ��������� ���������� �� ���
procedure TfrmMain.lstPeopleListClick(Sender: TObject);
var
  j,k: Byte;
  i: Integer;
  s: string;
  dp: gtl.TDMSParams;
  ag: gtl.TActGroups;
begin
  mmoPerson.Lines.Clear;
  i:= lstPeopleList.ItemIndex;
  s:= '������ ���: ';
    for j:=0 to 2 do
    begin
      case Planet.people[i].props.name[j][0] of
      0: begin
           if (Planet.people[i].props.gender) then
           begin
             s:= s + Planet.store.data.mnames.prim[Planet.people[i].props.name[j][1]]+' ';
           end
           else
           begin
             s:= s + Planet.store.data.fnames.prim[Planet.people[i].props.name[j][1]]+' ';
           end;
         end;
      1: begin
           if (Planet.people[i].props.gender) then
           begin
             s:= s + Planet.store.data.mnames.low[Planet.people[i].props.name[j][1]]+' ';
           end
           else
           begin
             s:= s + Planet.store.data.fnames.low[Planet.people[i].props.name[j][1]]+' ';
           end;
         end;
      2: begin
           if (Planet.people[i].props.gender) then
           begin
             s:= s + Planet.store.data.mnames.high[Planet.people[i].props.name[j][1]]+' ';
           end
           else
           begin
             s:= s + Planet.store.data.fnames.high[Planet.people[i].props.name[j][1]]+' ';
           end;
         end;
      3: begin
           if (Planet.people[i].props.gender) then
           begin
             s:= s + Planet.store.data.mnames.arch[Planet.people[i].props.name[j][1]]+' ';
           end
           else
           begin
             s:= s + Planet.store.data.fnames.arch[Planet.people[i].props.name[j][1]]+' ';
           end;
         end;
      end;
    end;
  mmoPerson.Lines.Add(s);
  s:= '���: ';
  if (Planet.people[i].props.gender) then
    s:= s + '�������'
  else
    s:= s + '�������';
  mmoPerson.Lines.Add(s);
  s:= '������� (����������� ���): ';
  s:= s + IntToStr(Planet.people[i].props.age);
  mmoPerson.Lines.Add(s);
  s:= '����: ';
  if (Planet.people[i].props.gender) then
    s:= s + IntToStr(Planet.store.data.heitype[Planet.people[i].props.origin, 0, Planet.people[i].props.outlook[ol_bodytype]][0]) +' ��'
  else
    s:= s + IntToStr(Planet.store.data.heitype[Planet.people[i].props.origin, 1, Planet.people[i].props.outlook[ol_bodytype]][0]) +' ��';
  mmoPerson.Lines.Add(s);
  s:= '���: ';
  if (Planet.people[i].props.gender) then
    s:= s + IntToStr(Planet.store.data.heitype[Planet.people[i].props.origin, 0, Planet.people[i].props.outlook[ol_bodytype]][1]) +' ��'
  else
    s:= s + IntToStr(Planet.store.data.heitype[Planet.people[i].props.origin, 1, Planet.people[i].props.outlook[ol_bodytype]][1]) +' ��';
  mmoPerson.Lines.Add(s);
  mmoPerson.Lines.Add('-------------------------------------------------------');
  s:= '��������� �������: ';
  mmoPerson.Lines.Add(s);
  s:= '��� ������������: ';
  s:= s + Planet.store.data.bodytype[Planet.people[i].props.origin, Planet.people[i].props.outlook[ol_bodytype]];
  mmoPerson.Lines.Add(s);
  s:= '���� ����: ';
  s:= s + Planet.store.data.eyes[Planet.people[i].props.origin, Planet.people[i].props.outlook[ol_eyes]];
  mmoPerson.Lines.Add(s);
  s:= '���� �����: ';
  s:= s + Planet.store.data.hairs[Planet.people[i].props.origin, Planet.people[i].props.outlook[ol_hair]];
  mmoPerson.Lines.Add(s);
  s:= '���� ����: ';
  s:= s + Planet.store.data.skins[Planet.people[i].props.origin, Planet.people[i].props.outlook[ol_skin]];
  mmoPerson.Lines.Add(s);
    mmoPerson.Lines.Add('-------------------------------------------------------');
  s:= '������ �������: ';
  mmoPerson.Lines.Add(s);
  s:= Planet.store.data.perks[Planet.people[i].props.origin, Planet.people[i].props.outlook[ol_perk1]];
  mmoPerson.Lines.Add(s);
  s:= Planet.store.data.perks[Planet.people[i].props.origin, Planet.people[i].props.outlook[ol_perk2]];
  mmoPerson.Lines.Add(s);
  s:= Planet.store.data.perks[Planet.people[i].props.origin, Planet.people[i].props.outlook[ol_perk3]];
  mmoPerson.Lines.Add(s);
  mmoPerson.Lines.Add('-------------------------------------------------------');
  s:= '����� �������� �� ����������� ��������� �������������: ';
  s:= s + Planet.store.data.hwtype[Planet.people[i].props.origin];
  mmoPerson.Lines.Add(s);
  mmoPerson.Lines.Add('-------------------------------------------------------');
  //��������� � ���������� �� 01.02.2015
  //������ ���� ����������� ������������ � ����������� ����������
  //��������� ���� ���������� ��������, ����������� ������ �����, ���������, ���������� ���������, ���������
  s:= '�������������: ';
  s:= s + Planet.store.data.cnames[Planet.people[i].props.specialty];
  mmoPerson.Lines.Add(s);
  mmoPerson.Lines.Add('-------------------------------------------------------');
  s:= '��������: ';
  s:= s + Planet.store.data.pnames[Planet.people[i].props.psychotype];
  mmoPerson.Lines.Add(s);
  mmoPerson.Lines.Add('-------------------------------------------------------');
  s:= '���������� ������, � ������� ������� ������: ';
  mmoPerson.Lines.Add(s);
  for j:=0 to 9 do
    if (Planet.people[i].props.factions[j]) then
      mmoPerson.Lines.Add(Planet.store.data.factions[j]);
  mmoPerson.Lines.Add('-------------------------------------------------------');
  s:= '��������������� ������ ����������: ';
  mmoPerson.Lines.Add(s);
  for j:=0 to 8 do
  begin
    s:= Planet.store.data.snames[j] + ': ' + IntToStr(Planet.people[i].props.stats[j]);
    mmoPerson.Lines.Add(s);
  end;
  mmoPerson.Lines.Add('-------------------------------------------------------');
  //���������� �� 16.07.2015
  //������������ ���������� DMS � ����������� ���������
  //��������� DMS
  mmoPerson.Lines.Add('������ ���������� ��������� �������');
  for dp:= dp_diligence to dp_authority do
  begin
    s:= ''; //
    s:= s + Planet.store.data.dmsnames[dp] + ': ' + IntToStr(Planet.people[i].props.dmsparams[dp]);
    mmoPerson.Lines.Add(s);
  end;
  mmoPerson.Lines.Add('-------------------------------------------------------');
  //����������
  mmoPerson.Lines.Add('���������� ������������ ����������� �������: ');
  for ag:= ag_force to ag_others do
  begin
    s:= '';
    s:= s + Planet.store.data.actnames[ag] + ': ' + IntToStr(Planet.people[i].props.addictions[ag]);
    mmoPerson.Lines.Add(s);
  end;
  mmoPerson.Lines.Add('-------------------------------------------------------');
  //���������� �� 05.02.2015
  //������������ ��������� ���
  s:= '������ �������������� ���������: ';
  mmoPerson.Lines.Add(s);
  for k:= 0 to 5 do
  begin
    s:='';
  if (Planet.people[i].props.contacts[k] <> -1) then
  begin
  for j:=0 to 2 do
    begin
      case Planet.people[Planet.people[i].props.contacts[k]].props.name[j][0] of
      0: begin
           if (Planet.people[Planet.people[i].props.contacts[k]].props.gender) then
           begin
             s:= s + Planet.store.data.mnames.prim[Planet.people[Planet.people[i].props.contacts[k]].props.name[j][1]]+' ';
           end
           else
           begin
             s:= s + Planet.store.data.fnames.prim[Planet.people[Planet.people[i].props.contacts[k]].props.name[j][1]]+' ';
           end;
         end;
      1: begin
           if (Planet.people[Planet.people[i].props.contacts[k]].props.gender) then
           begin
             s:= s + Planet.store.data.mnames.low[Planet.people[Planet.people[i].props.contacts[k]].props.name[j][1]]+' ';
           end
           else
           begin
             s:= s + Planet.store.data.fnames.low[Planet.people[Planet.people[i].props.contacts[k]].props.name[j][1]]+' ';
           end;
         end;
      2: begin
           if (Planet.people[Planet.people[i].props.contacts[k]].props.gender) then
           begin
             s:= s + Planet.store.data.mnames.high[Planet.people[Planet.people[i].props.contacts[k]].props.name[j][1]]+' ';
           end
           else
           begin
             s:= s + Planet.store.data.fnames.high[Planet.people[Planet.people[i].props.contacts[k]].props.name[j][1]]+' ';
           end;
         end;
      3: begin
           if (Planet.people[Planet.people[i].props.contacts[k]].props.gender) then
           begin
             s:= s + Planet.store.data.mnames.arch[Planet.people[Planet.people[i].props.contacts[k]].props.name[j][1]]+' ';
           end
           else
           begin
             s:= s + Planet.store.data.fnames.arch[Planet.people[Planet.people[i].props.contacts[k]].props.name[j][1]]+' ';
           end;
         end;
      end;
    end;
  s:= s + ' (' + IntToStr(Planet.people[i].props.contacts[k])+')';
  mmoPerson.Lines.Add(s);
  end;
  end;
  mmoPerson.Lines.Add('-------------------------------------------------------');
end;

//��������� ����
procedure TfrmMain.btnTurnClick(Sender: TObject);
begin
//��� �������� ����� �� 1 ���� ������
  Planet.time[2]:= Planet.time[2] + 1;
//� ������ 30 ����, ��� ������ ������� ���� ������������ �� 30, ���������� ��� � ������ � �������� ����� �� �������
  if (Planet.time[2] > 30) then
  begin
    Planet.time[2]:= 1;
    Planet.time[1]:= Planet.time[1] + 1;
  end;
//� ���� 12 �������, ��� ������ ������� ������� ��������� �� 12, ���������� ��� � ������ � �������� ������� ��� �� �������  
  if (Planet.time[1] > 12) then
  begin
    Planet.time[1]:= 1;
    Planet.time[0]:= Planet.time[0] + 1;
  end;
//������� ����������� ����� �� �����
  lbledtYear.Text:= IntToStr(Planet.time[0]); //���
  lbledtMonth.Text:= IntToStr(Planet.time[1]); //�����
  lbledtDay.Text:= IntToStr(Planet.time[2]); //����

end;

end.
