//������ �������� � ���������� ����� ������ ������� "����������"
//����������� ���������� �.�.

unit gtl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

//<-------------------------------------------------------------------------->\\
//<------------------------------���������----------------------------------->\\
//<-------------------------------------------------------------------------->\\

const

//��������� ������� �������
  FREE_INDEX = -1;

//��������� ��� ������ ��  ��������� ������/�������
  SUCCESS_GRADE = 10; //������ ������� ������ (��������� ��� ���������)
  MIN_SUCCESS_GRADE = -3; //������ ������ �������� ������/�������
  MAX_SUCCESS_GRADE = 3; //������� ������ �������� ������/�������


//��������� ��� ��������� ���������� ����� "������� ������"
  DICE_D20 = 20;
  DICE_D100 = 100;

//��������� ��� ������ � ��������� ����������
  AGE_BASE = 25; //���� - �����, ������ �������� ������ �������
  AGE_SEED = 30; //���� - �����, �� �������� ������������ �������� � ���� (���������)
  AGE_DIFF = 30; //������� - �����, �� �������� ������������ ������� � ����� �������������� ����

  FACT_MOD_LIM = 20; //��������� ���������� ���������� �������� ���������� ������������ �������

  MAX_PARTY_SIZE = 5; //����������� ��������� ������ ������

  HERESY_ORD_CHANCE = 25; //��������� ����������� ��������� ��� ������� "�����"

//��������� �������� ����������� ���������� (������� �������� �������� ��������)
  DISTRICT_SIZE = 999; //��������� ������� ������ (���� ������, ���� � ��� ����� ���� �����)
  HOUSE_CAPACITY = 9; //��������� ������� ���� (������� ������� � ��� ���������� - 1)

//������� �������� �������� ��������
  FACTIONS_COUNT = 9; //��������� �������� ������� ����� �������
  ORIGINS_COUNT = 3; //��������� �������� ������� ����� ������ �����
  CLASS_COUNT = 7; //��������� ����� �������
  NAMES_COUNT = 29; //��������� ����� ���� � �������� ������
  STATS_COUNT = 8; //��������� ����� ������������� ���������
  CONTACTS_COUNT = 5; //��������� ����������� ����� ��������� ���������
  FEATS_COUNT = 4; //��������� ����� �������� �������� ���������
  PERKS_COUNT = 15; //��������� ����� ������ ������ �� ������ ���
  PSYCHOTYPES_COUNT = 8; //��������� ����� ����������
  ACTIONS_COUNT = 4; //��������� ����� �������� � ������

//��������� ��������� ����������
  START_YEAR = 40000; //����������� ��������� ���
  MONTHS_COUNT = 12; //����� �������
  WEEK_DAYS_COUNT = 7; //����� ���� ������

//���������� ��� ������ � "���������"
//"������" - ������ ������ ���������, ������� �������� ������������. ��� ������ ���� ����� ������������, ���� �������� �����������.
//���������� ����� �������� � ���� ��������� ������ �������� ������ � ������ �� ������ ������ "�������"

//������������� ��������� ��� "��������"
  PH_STAT_DISPERSION = 5; //��������� ��������� ��������� ������������� ��������� - ������������ �� ����������� �������� ������� ������������ ��������� �������� �������������� ���������
  PH_DMS_DISPERSION = 20; //��������� ��������� ��������� ���������� DMS ���������
  PH_ADD_DISPERSION = 20; //��������� ��������� ��������� ���������� ����������� ���������

//������������� ��������� ��� ������ � "���������"
  PH_FACT_VISIBILTY_PROB = 50; //��������� ����������� ��������� ������� (������� - ��� ���������� ������� ������������� � ����� �� �������)
  PH_CLASS_VISIBILTY_PROB = 50; //��������� ����������� ��������� ������ ��������� (������� - ��. ����)
  PH_ORIGIN_VISIBILITY_PROB = 50; //��������� ����������� ��������� ������������� (�������)
  PH_START_REAL_PROB = 10; //��������� ����������� ��������� �������� ���� ������������� � "�������� ��������"
  PH_START_NODATA_PROB = 45; //��������� ����������� ��������� �������� ���� ������������� � "��� ������"
  PH_START_PHANTOM_PROB = 45; //���������� ����������� ��������� �������� ���� ������������� � "������ �������"

//��������� � ���������� ��������� ��� ������ � "���������"
  PH_NONDEF_PROP = '��� ������'; //���������, ��������� ��� ������������� �������� (���� �������� "�������" ��������, ��� �������� �� ���������� �������� �������� ���� ��������� FREE_INDEX)

//��������� � ���������� ���������

//������� ���������
  SANTIMETER_NAME = '��'; //
  KILOGRAMM_NAME = '��'; //


//<-------------------------------------------------------------------------->\\

type

//<-------------------------------------------------------------------------->\\
//<----------------------------- ���� ������ -------------------------------->\\
//<-------------------------------------------------------------------------->\\

//��� ������������ ���������� �������� ��������� (����, ���, ���� ����, ���� ����, ���� �����, 3 ������ �������)
  TOutlook = (ol_bodytype, ol_skin, ol_eyes, ol_hair, ol_perk1, ol_perk2, ol_perk3);

//��� ������������ ����� ����� (�� ����������, �����, ��������, �������, ���)
  TTargetKind = (tk_nondef, tk_place, tk_person, tk_item, tk_self);

//
  TClueKind = (ck_);

//��� ������������ ����� �������� (������� �������� �������� ������������ ������)
  TActGroups = (ag_force, ag_court, ag_stealth, ag_investigation, ag_others);

//��� ������������ ����� �������� (����� �������� ������� ��������� ������ ������ �����, �����)
  TOrdGroups = (og_kill, og_capture, og_research, og_interrogate, og_search, og_freetime, og_heresy);

//��� ������������ ���������� DMS (���������������� ������������ ������������ ����������� ��������������)
  TDMSParams = (dp_diligence, dp_identity, dp_calmness, dp_educability, dp_authority);

//��� ������ ������� �����
  TBytePair = array [0..1] of Byte;

//���������� ��� �� ������
  TSCent = -100..100;

//��� ����� ����
  TNameString = string[60];

//��� ��������� ���� �������������
//vs_nodata-������ ����������, vs_real-�������� ������, vs_phantom-������ �� "�������"
  TVisualiserSrc = (vs_nodata, vs_real, vs_phantom);

//��� ������������ ����������� ��������
//ar_grdeath_all, ar_grdeath_half, ar_grwound_all, ar_grwound_half,
//ar_tgt_destroy, ar_tgt_capture, ar_act_unavailible,
//ar_new_recruits, ar_extra_exp, ar_new_info, ar_stat_up,
//ar_std_fail, ar_new_witness, ar_hpchange, ar_new_item
  TActionResult = (ar_grdeath_all, ar_grdeath_half, ar_grwound_all, ar_grwound_half, ar_tgt_destroy, ar_tgt_capture, ar_act_unavailible, ar_new_recruits, ar_extra_exp, ar_new_info, ar_stat_up, ar_std_fail, ar_new_witness, ar_hpchange, ar_new_item);

//��� �������� ����
  TStrArr = array [0..NAMES_COUNT] of TNameString;

//��� ������ � ����������� ����
  TTarget = record
    Availible: Boolean; //������ �����������
    MaxAmount: Integer; //����������� ��������� ����� ����� ������� ����
  end;

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
    clasmods: array [0..CLASS_COUNT] of TAddiction; //������������ ������
    factmods: array [0..FACTIONS_COUNT] of TAddiction; //������������ �������
    origmods: array [0..ORIGINS_COUNT] of TAddiction; //������������ �������������
  end;

//��� ����� ������������� ���������� DMS
  TDMSMods = record
    clasmods: array [0..CLASS_COUNT] of TDMSArr; //������������ ������
    factmods: array [0..FACTIONS_COUNT] of TDMSArr; //������������ �������
    origmods: array [0..ORIGINS_COUNT] of TDMSArr; //������������ �������������
  end;

//��� ��������� ��������� ������� ��������
  TSuccessGrades = array [MIN_SUCCESS_GRADE..MAX_SUCCESS_GRADE] of TActionResult;

//������ ������ �������� ��������
  TGameActionData =record
    name: TNameString; //������ �������� �������� � ����-���������
    description: String; //������ �������� �������� � ����-���������
    targets: array [TTargetKind] of TTarget; //������ ��������� ����� � �� ����������
    actors: TBytePair; //����� ������������: ��������� � ������������
    results: TSuccessGrades; //��������� ������ ��������
  end;

//��� �������� ��������
  TActSubGroup = array [0..ACTIONS_COUNT] of TGameActionData;

//��� ������ ��������
  TActDataList = array [TActGroups] of TActSubGroup;

//��� ������ ���������� ��������������� ��������
  TFactActionData = record
    Name: TNameString; //��������
    Description: String; //��������
    TgtKind: TTargetKind; //��� ����
    TgtId: array [0..MAX_PARTY_SIZE] of Integer; //����� �����
    StatsUsed: array [0..STATS_COUNT] of Boolean; //������������ ���������
    results: TSuccessGrades; //������ ��������� �������
    difficulty: Byte; //��������� ��������
  end;

//��� ������
  TActResultData = record
    parent: TNameString; //��������
    kind: TActionResult; //��� ����������
    TgtKind: TTargetKind; //��� ����, � ������� ����������� ����������� ����������
    TgtId: array [0..MAX_PARTY_SIZE] of Integer; //������� �����, � ������� ����������� ��������� (���� ����� ����� ���� ���-��, � ��������� ������ ������� -1)
  end;

//��� ����������� ����-����������
  TStorageData = record
    mnames: TDialNames; //������� �����
    fnames: TDialNames; //������� �����
    cnames: array [0..CLASS_COUNT] of TNameString; //�������� ��������� (��������� 01.02.2015)
    snames: array [0..STATS_COUNT] of TNameString; //�������� ���������� ��������� (��������� 01.02.2015)
    pnames: array [0..PSYCHOTYPES_COUNT] of TNameString; //�������� ���������� (��������� 01.02.2015)
    plnames: array [0..9] of TNameString; //���������� ������ ������ (��������� 29.05.2015)
    dmsnames: array [TDMSParams] of TNameString; //�������� ���������� DMS (��������� 16.07.2015)
    actnames: array [TActGroups] of TNameString; //�������� ����� ��������
    ordnames: array [TOrdGroups] of TNameString; //�������� ��������
    sbonus: array [0..ORIGINS_COUNT, 0..STATS_COUNT] of Byte; //������ ���������� �� ������� ���� (��������� 01.02.2015)
    sprobs: array [0..ORIGINS_COUNT, 0..CLASS_COUNT] of Byte; //����������� ��������� � ����������� �� ������������� (��������� 01.02.2015)
    lprobs: array [0..3] of Byte; //����������� ����������� (��������� 01.02.2015)
    factions: array [0..FACTIONS_COUNT] of TNameString; //�������� ������� (��������� 01.02.2015)
    fprobs: array [0..FACTIONS_COUNT] of Byte; //����������� ���������� �������� (��������� 01.02.2015)
    gender: array [0..2] of TNameString; //�������� �����
    hwtype: array [0..ORIGINS_COUNT] of TNameString; //��� ������� ����
    bodytype: array [0..ORIGINS_COUNT, 0..FEATS_COUNT] of TNameString; //��� ������������
    heitype: array [0..ORIGINS_COUNT, 0..1, 0..FEATS_COUNT] of TBytePair; //��� ������ ����/��� (������ ����������: ��� ������� ����, ���, ��������) ������ ����� - ���� (��) ������ ���(��)
    skins: array [0..ORIGINS_COUNT, 0..FEATS_COUNT] of TNameString; //����� ����
    hairs: array [0..ORIGINS_COUNT, 0..FEATS_COUNT] of TNameString; //����� �����
    eyes: array [0..ORIGINS_COUNT, 0..FEATS_COUNT] of TNameString;  //����� ����
    perks: array [0..ORIGINS_COUNT, 0..PERKS_COUNT] of TNameString; //������ ������ ������
    addmods: TAddMods; //��������� ������������� ���������� (��������� 01.07.2015)
    dmsmods: TDMSMods; //��������� ������������� ���������� DMS (��������� 03.07.2015)
    actions: TActDataList; //��������� ������ � ���������
    grexe: TNameString; //������ � ����������� ����������� ������ (��������� 05.02.2015)
  end;

//��� ������ ���
  THumanData = record
    name: array [0..2] of TBytePair; //��� (������� �������� ������ � ������ ����� � ������)
    address: integer; //����� ����, � ������� ����� ���
    age: Integer; //�������
    gender: Boolean; //���
    outlook: array [TOutlook] of Byte; //������� ��� ���������
    origin: Byte; //��� ������� ����
    factions: array [0..FACTIONS_COUNT] of Boolean; //������ ��������������� � �������� (��������� �� 01.02.2015 - ������� ���� isheretic � ispsyker, ������� ���� factions)
    ladder: array [0..FACTIONS_COUNT] of Byte; //��������� ��� ������ ������� (�������, ������������, ��������, ����. ������������ ��������� 3 ��������, �������� - 3 ��������������, ���� - 3 �����������)(��������� 01.02.2015)
    specialty: Byte; //����� ��� (��������� 01.02.2015)
    psychotype: Byte; //�������� (��������� 01.02.2015)
    addictions: TAddiction; //���������� ��� (��������� 01.07.2015)
    dmsparams: TDMSArr; //��������� DMS ��� (��������� 03.07.2015)
    stats: array [0..STATS_COUNT] of Byte; //������ ���������� ��� (��������� 01.02.2015)
    contacts: array [0..CONTACTS_COUNT] of Integer; //������ ��������� ���
    isfree: Boolean; //
  end;

//��� ������ ������������� ��� "�������"
  TVisualiserData = record
    name: array [0..2] of TVisualiserSrc;
    address: TVisualiserSrc;
    age: TVisualiserSrc;
    gender: TVisualiserSrc;
    origin: TVisualiserSrc;
    factions: array[0..FACTIONS_COUNT] of TVisualiserSrc;
    ladder: array [0..FACTIONS_COUNT] of TVisualiserSrc;
    specialty: TVisualiserSrc;
    psychotype: TVisualiserSrc;
    stats: array [0..STATS_COUNT] of TVisualiserSrc;
    contacts: array [0..CONTACTS_COUNT] of TVisualiserSrc;
  end;

implementation

end.
