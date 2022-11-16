unit NegMuRelaxInputFile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, system.StrUtils,System.IOUtils;    

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label6: TLabel;
    Edit4: TEdit;
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    ComboBox3: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    CheckBox2: TCheckBox;
    ComboBox4: TComboBox;
    Label9: TLabel;
    ComboBox5: TComboBox;
    Label10: TLabel;
    Edit5: TEdit;
    CheckBox3: TCheckBox;
    Label11: TLabel;
    Edit6: TEdit;
    Label12: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    GroupBox3: TGroupBox;
    Label13: TLabel;
    Edit10: TEdit;
    CheckBox4: TCheckBox;
    Edit11: TEdit;
    CheckBox5: TCheckBox;
    ComboBox6: TComboBox;
    GroupBox4: TGroupBox;
    Edit12: TEdit;
    GroupBox5: TGroupBox;
    Edit13: TEdit;
    Button1: TButton;
    GroupBox6: TGroupBox;
    Label14: TLabel;
    SaveFile: TEdit;
    GroupBox7: TGroupBox;
    ComboBox7: TComboBox;
    Label15: TLabel;
    GroupBox9: TGroupBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    ComboBox8: TComboBox;
    ComboBox9: TComboBox;
    ComboBox10: TComboBox;
    ComboBox11: TComboBox;
    ComboBox12: TComboBox;
    ComboBox13: TComboBox;
    ComboBox14: TComboBox;
    CheckBox13: TCheckBox;
    Button2: TButton;
    CheckBox14: TCheckBox;
    Edit14: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure CheckBox13Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox14Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
var
F,F2,F3: TextFile; XYZ,XYZ2,XYZ3, atomicspecies,atomicspecies1,atomicspecies2: TStringList; 
a1,a2,a3,b1,b2,b3,c1,c2,c3,b1neg,b2neg,c1neg,c2neg,c3neg: double; 
lines, i, atomicspecieslines: integer;
before, after, thiselement,thiselement2,thiselement3,thisatom, thisatomx, thisatomy, thisatomz,mass,mass2,mass3,mass4,mass5,mass6,mass7: string;
const 
  myelements: array [1 .. 50] of string = ('H', 'He', 'Li', 'Be', 'B', 'C', 'N',
    'O', 'F', 'Ne', 'Na', 'Mg', 'Al', 'Si', 'P', 'S', 'Cl', 'Ar', 'K', 'Ca',
    'Sc', 'Ti', 'V', 'Cr', 'Mn', 'Fe', 'Co', 'Ni', 'Cu', 'Zn', 'Ga', 'Ge', 'As',
    'Se', 'Br', 'Kr', 'Rb', 'Sr', 'Y', 'Zr', 'Nb', 'Mo', 'Tc', 'Ru', 'Rh', 'Pd',
    'Ag', 'Cd', 'In', 'Sn');

  mymass: array [1..50] of string = ('1.00797','4.00260','6.941','9.01218','10.81','12.011','14.0067','15.9994','18.998403','20.179',
    '22.98977','24.305','26.98154','28.0855','30.97376','32.06','35.453','39.948','39.098','40.078','44.956','47.867','50.942','51.996','54.938','55.845','58.933','58.693',
    '63.546','65.38','69.723','72.630','74.922','78.971','79.904','83.798','85.468','87.62','88.906','91.224','92.906','95.95','97','101.07','102.91','106.42',
    '107.87','112.41','114.82','118.71');
begin

//atomicspecies: Creates a stringlist to store the atomic species used, which then is used to calculate nat and ntyp
//XYZ loads in the .xyz coordinate file
atomicspecies := TstringList.Create;
atomicspecies1 := TstringList.Create;
atomicspecieslines := atomicspecies.Count;
XYZ := TStringList.Create;
XYZ.LoadFromFile(Edit13.Text);
XYZ2 := TStringList.Create;
XYZ2.LoadFromFile(Edit13.Text);
XYZ3 := TStringList.Create;
XYZ3.LoadFromFile(Edit13.Text);
lines := XYZ.Count;

// Manipulates the .p1 file to change an atom into a Z-1 pseudonucleus with muonic atom checkbox
if CheckBox13.Checked then
  for i := 8 to lines-1 do
    begin
    if SplitString(XYZ[i], ' ')[25] = '' then
      thiselement := SplitString(XYZ[i], ' ')[24]
    else
      thiselement := SplitString(XYZ[i], ' ')[25];
    if (thiselement[3] = '1') or (thiselement[2] = '1') then
        SetLength(thiselement, Length(thiselement) -1);
    if thiselement = myelements[ComboBox7.Itemindex+1] then
      begin
        XYZ[i]:= StringReplace(XYZ[i], myelements[ComboBox7.Itemindex+1], myelements[ComboBox7.ItemIndex],[]);
        break
      end;
    end;
  for i := 8 to lines-1 do
    begin
    if SplitString(XYZ2[i], ' ')[25] = '' then
      thiselement2 := SplitString(XYZ2[i], ' ')[24]
    else
      thiselement2 := SplitString(XYZ2[i], ' ')[25];
    if (thiselement2[3] = '2') or (thiselement2[2] = '2') then
        SetLength(thiselement2, Length(thiselement2) -1);
    if thiselement2 = myelements[ComboBox7.Itemindex+1] then
      begin
        XYZ2[i]:= StringReplace(XYZ2[i], myelements[ComboBox7.Itemindex+1], myelements[ComboBox7.ItemIndex],[]);
        break
      end;
    end;
  for i := 8 to lines-1 do
    begin
    if SplitString(XYZ3[i], ' ')[25] = '' then
      thiselement3 := SplitString(XYZ3[i], ' ')[24]
    else
      thiselement3 := SplitString(XYZ3[i], ' ')[25];
    if (thiselement3[3] = '3') or (thiselement3[2] = '3') then
        SetLength(thiselement3, Length(thiselement3) -1);
    if thiselement3 = myelements[ComboBox7.Itemindex+1] then
      begin
        XYZ3[i]:= StringReplace(XYZ3[i], myelements[ComboBox7.Itemindex+1], myelements[ComboBox7.ItemIndex],[]);
        break
      end;
    end;



// This section controls what mass is added into the atomic species
if CheckBox6.Checked then
  begin
    if ComboBox8.Text[2] <> '.' then
    begin
      for i := 1 to Length(myelements) do
        begin
          if (ComboBox8.Text[1] + ComboBox8.Text[2]) = myelements[i] then
          mass := mymass[i];
        end;
    end;
    if ComboBox8.Text[2] = '.' then
       begin
        for i := 1 to Length(myelements) do
          begin
            if (ComboBox8.Text[1]) = myelements[i] then
            mass := mymass[i];
          end;
      end;
    end;

if CheckBox7.Checked then
  begin
    if ComboBox9.Text[2] <> '.' then
    begin
      for i := 1 to Length(myelements) do
        begin
          if (ComboBox9.Text[1] + ComboBox9.Text[2]) = myelements[i] then
          mass2 := mymass[i];
        end;
    end;
    if ComboBox9.Text[2] = '.' then
       begin
        for i := 1 to Length(myelements) do
          begin
            if (ComboBox9.Text[1]) = myelements[i] then
            mass2 := mymass[i];
          end;
      end;
    end;

if CheckBox8.Checked then
  begin
    if ComboBox10.Text[2] <> '.' then
    begin
      for i := 1 to Length(myelements) do
        begin
          if (ComboBox10.Text[1] + ComboBox10.Text[2]) = myelements[i] then
          mass3 := mymass[i];
        end;
    end;
    if ComboBox10.Text[2] = '.' then
       begin
        for i := 1 to Length(myelements) do
          begin
            if (ComboBox10.Text[1]) = myelements[i] then
            mass3 := mymass[i];
          end;
      end;
    end;

if CheckBox9.Checked then
  begin
    if ComboBox11.Text[2] <> '.' then
    begin
      for i := 1 to Length(myelements) do
        begin
          if (ComboBox11.Text[1] + ComboBox11.Text[2]) = myelements[i] then
          mass4 := mymass[i];
        end;
    end;
    if ComboBox11.Text[2] = '.' then
       begin
        for i := 1 to Length(myelements) do
          begin
            if (ComboBox11.Text[1]) = myelements[i] then
            mass4 := mymass[i];
          end;
      end;
    end;

if CheckBox10.Checked then
  begin
    if ComboBox12.Text[2] <> '.' then
    begin
      for i := 1 to Length(myelements) do
        begin
          if (ComboBox12.Text[1] + ComboBox12.Text[2]) = myelements[i] then
          mass5 := mymass[i];
        end;
    end;
    if ComboBox10.Text[2] = '.' then
       begin
        for i := 1 to Length(myelements) do
          begin
            if (ComboBox12.Text[1]) = myelements[i] then
            mass5 := mymass[i];
          end;
      end;
    end;

if CheckBox11.Checked then
  begin
    if ComboBox13.Text[2] <> '.' then
    begin
      for i := 1 to Length(myelements) do
        begin
          if (ComboBox13.Text[1] + ComboBox13.Text[2]) = myelements[i] then
          mass6 := mymass[i];
        end;
    end;
    if ComboBox13.Text[2] = '.' then
       begin
        for i := 1 to Length(myelements) do
          begin
            if (ComboBox13.Text[1]) = myelements[i] then
            mass6 := mymass[i];
          end;
      end;
    end;

if CheckBox12.Checked then
  begin
    if ComboBox14.Text[2] <> '.' then
    begin
      for i := 1 to Length(myelements) do
        begin
          if (ComboBox14.Text[1] + ComboBox14.Text[2]) = myelements[i] then
          mass7 := mymass[i];
        end;
    end;
    if ComboBox14.Text[2] = '.' then
       begin
        for i := 1 to Length(myelements) do
          begin
            if (ComboBox14.Text[1]) = myelements[i] then
            mass7 := mymass[i];
          end;
      end;
    end;
// End of mass adding to atomic species

// Adds the atomic species
//if CheckBox6.Checked then
//for i := 8 to lines - 1 do
//  begin
//    if SplitString(XYZ[i], ' ')[25] = '' then
//      atomicspecies.Add(SplitString(XYZ[i], ' ')[24])
//    else
//      atomicspecies.Add(SplitString(XYZ[i], ' ')[25]);
//  ShowMessage(atomicspecies.Text);
//  end;

if CheckBox6.Checked then 
begin
atomicspecies.Add(ComboBox8.Text[1] + ComboBox8.Text[2]);
atomicspecies1.Add(ComboBox8.Text[1] + ComboBox8.Text[2]);
end;
if CheckBox7.Checked then 
begin
atomicspecies.Add(ComboBox9.Text[1] + ComboBox9.Text[2]);
atomicspecies1.Add(ComboBox9.Text[1] + ComboBox9.Text[2]);
end;

if CheckBox8.Checked then 
begin
atomicspecies.Add(ComboBox10.Text[1] + ComboBox10.Text[2]);
atomicspecies1.Add(ComboBox10.Text[1] + ComboBox10.Text[2]);
end;

if CheckBox9.Checked then 
begin
atomicspecies.Add(ComboBox11.Text[1] + ComboBox11.Text[2]);
atomicspecies1.Add(ComboBox11.Text[1] + ComboBox11.Text[2]);
end;

if CheckBox10.Checked then 
begin
atomicspecies.Add(ComboBox12.Text[1] + ComboBox12.Text[2]);
atomicspecies1.Add(ComboBox12.Text[1] + ComboBox12.Text[2]);
end;

if CheckBox11.Checked then 
begin
atomicspecies.Add(ComboBox13.Text[1] + ComboBox13.Text[2]);
atomicspecies1.Add(ComboBox13.Text[1] + ComboBox13.Text[2]);
end;

if CheckBox12.Checked then 
begin
atomicspecies.Add(ComboBox14.Text[1] + ComboBox14.Text[2]);
atomicspecies1.Add(ComboBox14.Text[1] + ComboBox14.Text[2]);
end;




//This whole section writes the input file for negative muon DFT 
AssignFile(F , SaveFile.Text+'\'+Edit2.Text+'.relax.muminus1.pwi');
ReWrite(F);
WriteLn(F, '&CONTROL');
WriteLn(F, '  calculation =' + QuotedStr(ComboBox1.Text));
WriteLn(F, '  restart_mode = ' + QuotedStr(ComboBox2.Text));
WriteLn(F, '  outdir = ' + QuotedStr(Edit1.Text));
WriteLn(F, '  prefix = ' + QuotedStr(Edit2.Text));
WriteLn(F, '   max_seconds = ' + Edit3.Text);
WriteLn(F, '  pseudo_dir = ' + QuotedStr(Edit4.Text));
WriteLn(F, '/' );
WriteLn(F, '&SYSTEM');
WriteLn(F, '  ecutwfc = ' + Edit8.Text);
WriteLn(F, '  ecutrho = ' + Edit9.Text);



if CheckBox1.Checked then
  begin
    WriteLn(F, '  tot_charge = ' + ComboBox3.Text)
  end;
if CheckBox2.Checked then
  begin
    WriteLn(F, '  occupations = ' + QuotedStr(ComboBox4.Text));
    WriteLn(F, '  smearing = ' + QuotedStr(ComboBox5.Text));
    WriteLn(F, '  degauss = ' + Edit5.Text);
  end;
if CheckBox3.Checked then
  begin
    WriteLn(F, '  lda_plus_u = ' + QuotedStr('.true.'));
    WriteLn(F, '  hubbard_u(1) = ' + Edit6.Text);
    if edit7.Text <> '' then
      WriteLn(F, '  hubbard_u(2) = ' + Edit7.Text);
  end;
WriteLn(F, '  ntyp = ' + ' ' + inttostr(atomicspecies.Count));
WriteLn(F, '  nat = ' + ' ' + inttostr(lines - 8));
WriteLn(F, '  ibrav = 0');  
WriteLn(F, '/');
WriteLn(F, '&ELECTRONS');
WriteLn(F, '  mixing_beta = ' + Edit10.Text);
if CheckBox4.Checked then
  begin
    WriteLn(F, '  electron_maxstep = ' + Edit11.Text);
  end;
if CheckBox5.Checked then
  begin
    WriteLn(F, '  mixing_mode = ' + QuotedStr(ComboBox6.Text));
  end;
WriteLn(F, '/');
WriteLn(F, '&IONS');
WriteLn(F, '  ion_dynamics =' + QuotedStr('bfgs'));
WriteLn(F, '/');
WriteLn(F, '&CELL');
WriteLn(F, '/');
WriteLn(F, 'ATOMIC_SPECIES');
if CheckBox6.Checked then
  begin
  if ComboBox8.Text[2] <> '.' then
    begin
    for i := 8 to lines-1 do
      begin
        if SplitString(XYZ[i], ' ')[25] = '' then
          atomicspecies.Add(SplitString(XYZ[i], ' ')[24])
        else
          atomicspecies.Add(SplitString(XYZ[i], ' ')[25]);
      end;
    atomicspecieslines := atomicspecies.Count;
    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox8.Text[1] + ComboBox8.Text[2] + '1' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass + ' ' + ComboBox8.Text);
        break
      end;
    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox8.Text[1] + ComboBox8.Text[2] + '2' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass + ' ' + ComboBox8.Text);
        break
      end;
    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox8.Text[1] + ComboBox8.Text[2] + '3' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass + ' ' + ComboBox8.Text);
        break
      end;
    end;
  if ComboBox8.Text[2] = '.' then
    begin
    for i := 8 to lines-1 do
      begin
        if SplitString(XYZ[i], ' ')[25] = '' then
          atomicspecies.Add(SplitString(XYZ[i], ' ')[24])
        else
          atomicspecies.Add(SplitString(XYZ[i], ' ')[25]);
      end;
    atomicspecieslines := atomicspecies.Count;
    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox8.Text[1] + '1' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass + ' ' + ComboBox8.Text);
        break
      end;
    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox8.Text[1] + '2' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass + ' ' + ComboBox8.Text);
        break
      end;
    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox8.Text[1] + '3' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass + ' ' + ComboBox8.Text);
        break
      end;
    end
  
  end;

if CheckBox7.Checked then
  begin
  if ComboBox9.Text[2] <> '.' then
    begin
    for i := 8 to lines-1 do
      begin
        if SplitString(XYZ[i], ' ')[25] = '' then
          atomicspecies.Add(SplitString(XYZ[i], ' ')[24])
        else
          atomicspecies.Add(SplitString(XYZ[i], ' ')[25]);
      end;
    atomicspecieslines := atomicspecies.Count;
    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox9.Text[1] + ComboBox9.Text[2] + '1' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass2 + ' ' + ComboBox9.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox9.Text[1] + ComboBox9.Text[2] + '2' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass2 + ' ' + ComboBox9.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox9.Text[1] + ComboBox9.Text[2] + '3' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass2 + ' ' + ComboBox9.Text);
        break
      end;
    end;
  if ComboBox9.Text[2] = '.' then
    begin
    for i := 8 to lines-1 do
      begin
        if SplitString(XYZ[i], ' ')[25] = '' then
          atomicspecies.Add(SplitString(XYZ[i], ' ')[24])
        else
          atomicspecies.Add(SplitString(XYZ[i], ' ')[25]);
      end;
    atomicspecieslines := atomicspecies.Count;
    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox9.Text[1] + '1' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass2 + ' ' + ComboBox9.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox9.Text[1] + '2' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass2 + ' ' + ComboBox9.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox9.Text[1] + '3' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass2 + ' ' + ComboBox9.Text);
        break
      end;
    end
  
  end;

if CheckBox8.Checked then
  begin
  if ComboBox10.Text[2] <> '.' then
    begin
    for i := 8 to lines-1 do
      begin
        if SplitString(XYZ[i], ' ')[25] = '' then
          atomicspecies.Add(SplitString(XYZ[i], ' ')[24])
        else
          atomicspecies.Add(SplitString(XYZ[i], ' ')[25]);
      end;
    atomicspecieslines := atomicspecies.Count;
    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox10.Text[1] + ComboBox10.Text[2] + '1' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass3 + ' ' + ComboBox10.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox10.Text[1] + ComboBox10.Text[2] + '2' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass3 + ' ' + ComboBox10.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox10.Text[1] + ComboBox10.Text[2] + '3' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass3 + ' ' + ComboBox10.Text);
        break
      end;
    end;
  if ComboBox10.Text[2] = '.' then
    begin
    for i := 8 to lines-1 do
      begin
        if SplitString(XYZ[i], ' ')[25] = '' then
          atomicspecies.Add(SplitString(XYZ[i], ' ')[24])
        else
          atomicspecies.Add(SplitString(XYZ[i], ' ')[25]);
      end;
    atomicspecieslines := atomicspecies.Count;
    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox10.Text[1] + '1' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass3 + ' ' + ComboBox10.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox10.Text[1] + '2' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass3 + ' ' + ComboBox10.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox10.Text[1] + '3' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass3 + ' ' + ComboBox10.Text);
        break
      end;
    end
  
  end;

if CheckBox9.Checked then
  begin
  if ComboBox11.Text[2] <> '.' then
    begin
    for i := 8 to lines-1 do
      begin
        if SplitString(XYZ[i], ' ')[25] = '' then
          atomicspecies.Add(SplitString(XYZ[i], ' ')[24])
        else
          atomicspecies.Add(SplitString(XYZ[i], ' ')[25]);
      end;
    atomicspecieslines := atomicspecies.Count;
    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox11.Text[1] + ComboBox11.Text[2] + '1' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass4 + ' ' + ComboBox11.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox11.Text[1] + ComboBox11.Text[2] + '2' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass4 + ' ' + ComboBox11.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox11.Text[1] + ComboBox11.Text[2] + '3' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass4 + ' ' + ComboBox11.Text);
        break
      end;
    end;
  if ComboBox11.Text[2] = '.' then
    begin
    for i := 8 to lines-1 do
      begin
        if SplitString(XYZ[i], ' ')[25] = '' then
          atomicspecies.Add(SplitString(XYZ[i], ' ')[24])
        else
          atomicspecies.Add(SplitString(XYZ[i], ' ')[25]);
      end;
    atomicspecieslines := atomicspecies.Count;
    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox11.Text[1] + '1' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass4 + ' ' + ComboBox11.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox11.Text[1] + '2' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass4 + ' ' + ComboBox11.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox11.Text[1] + '3' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass4 + ' ' + ComboBox11.Text);
        break
      end;
    end
  
  end;

if CheckBox10.Checked then
  begin
  if ComboBox12.Text[2] <> '.' then
    begin
    for i := 8 to lines-1 do
      begin
        if SplitString(XYZ[i], ' ')[25] = '' then
          atomicspecies.Add(SplitString(XYZ[i], ' ')[24])
        else
          atomicspecies.Add(SplitString(XYZ[i], ' ')[25]);
      end;
    atomicspecieslines := atomicspecies.Count;
    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox12.Text[1] + ComboBox12.Text[2] + '1' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass5 + ' ' + ComboBox12.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox12.Text[1] + ComboBox12.Text[2] + '2' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass5 + ' ' + ComboBox12.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox12.Text[1] + ComboBox12.Text[2] + '3' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass5 + ' ' + ComboBox12.Text);
        break
      end;
    end;
  if ComboBox12.Text[2] = '.' then
    begin
    for i := 8 to lines-1 do
      begin
        if SplitString(XYZ[i], ' ')[25] = '' then
          atomicspecies.Add(SplitString(XYZ[i], ' ')[24])
        else
          atomicspecies.Add(SplitString(XYZ[i], ' ')[25]);
      end;
    atomicspecieslines := atomicspecies.Count;
    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox12.Text[1] + '1' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass5 + ' ' + ComboBox12.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox12.Text[1] + '2' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass5 + ' ' + ComboBox12.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox12.Text[1] + '3' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass5 + ' ' + ComboBox12.Text);
        break
      end;
    end
  
  end;

if CheckBox11.Checked then
  begin
  if ComboBox13.Text[2] <> '.' then
    begin
    for i := 8 to lines-1 do
      begin
        if SplitString(XYZ[i], ' ')[25] = '' then
          atomicspecies.Add(SplitString(XYZ[i], ' ')[24])
        else
          atomicspecies.Add(SplitString(XYZ[i], ' ')[25]);
      end;
    atomicspecieslines := atomicspecies.Count;
    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox13.Text[1] + ComboBox13.Text[2] + '1' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass6 + ' ' + ComboBox13.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox13.Text[1] + ComboBox13.Text[2] + '2' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass6 + ' ' + ComboBox13.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox13.Text[1] + ComboBox13.Text[2] + '3' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass6 + ' ' + ComboBox13.Text);
        break
      end;
    end;
  if ComboBox12.Text[2] = '.' then
    begin
    for i := 8 to lines-1 do
      begin
        if SplitString(XYZ[i], ' ')[25] = '' then
          atomicspecies.Add(SplitString(XYZ[i], ' ')[24])
        else
          atomicspecies.Add(SplitString(XYZ[i], ' ')[25]);
      end;
    atomicspecieslines := atomicspecies.Count;
    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox13.Text[1] + '1' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass6 + ' ' + ComboBox13.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox13.Text[1] + '2' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass6 + ' ' + ComboBox13.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox13.Text[1] + '3' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass6 + ' ' + ComboBox13.Text);
        break
      end;
    end
  
  end;

if CheckBox12.Checked then
  begin
  if ComboBox14.Text[2] <> '.' then
    begin
    for i := 8 to lines-1 do
      begin
        if SplitString(XYZ[i], ' ')[25] = '' then
          atomicspecies.Add(SplitString(XYZ[i], ' ')[24])
        else
          atomicspecies.Add(SplitString(XYZ[i], ' ')[25]);
      end;
    atomicspecieslines := atomicspecies.Count;
    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox14.Text[1] + ComboBox14.Text[2] + '1' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass7 + ' ' + ComboBox14.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox14.Text[1] + ComboBox14.Text[2] + '2' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass7 + ' ' + ComboBox14.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox14.Text[1] + ComboBox14.Text[2] + '3' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass7 + ' ' + ComboBox14.Text);
        break
      end;
    end;
  if ComboBox12.Text[2] = '.' then
    begin
    for i := 8 to lines-1 do
      begin
        if SplitString(XYZ[i], ' ')[25] = '' then
          atomicspecies.Add(SplitString(XYZ[i], ' ')[24])
        else
          atomicspecies.Add(SplitString(XYZ[i], ' ')[25]);
      end;
    atomicspecieslines := atomicspecies.Count;
    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox14.Text[1] + '1' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass7 + ' ' + ComboBox14.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox14.Text[1] + '2' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass7 + ' ' + ComboBox14.Text);
        break
      end;

    for i := 0 to atomicspecieslines-1 do
      if atomicspecies[i] = ComboBox14.Text[1] + '3' then
      begin    
        WriteLn(F, atomicspecies[i]  + ' ' + mass7 + ' ' + ComboBox14.Text);
        break
      end;
    end
  
  end;

WriteLn(F, 'K_POINTS automatic');
WriteLn(F, Edit12.text + ' 0 0 0 ');
WriteLn(F, 'CELL_PARAMETERS angstrom');
for i := 2 to 4 do
  WriteLn(F, XYZ[i]);
WriteLn(F, 'ATOMIC_POSITIONS angstrom');
for i := 8 to lines -1 do
  begin
    if SplitString(XYZ[i], ' ')[25] = '' then
      thisatom := SplitString(XYZ[i], ' ')[24]
    else
      thisatom := SplitString(XYZ[i], ' ')[25];
    if SplitString(XYZ[i], ' ')[5] = '' then
      thisatomx := SplitString(XYZ[i], ' ')[4]
    else
      thisatomx := SplitString(XYZ[i], ' ')[5];
    if SplitString(XYZ[i], ' ')[14] = '' then
      thisatomy := SplitString(XYZ[i], ' ')[13]
    else
      thisatomy := SplitString(XYZ[i], ' ')[14];
    if SplitString(XYZ[i], ' ')[23] = '' then
      thisatomz := SplitString(XYZ[i], ' ')[22]
    else
      thisatomz := SplitString(XYZ[i], ' ')[23];
    WriteLn(F, thisatom + '   ' +  thisatomx + '   '  + thisatomy  + '   ' + thisatomz);
  end;

CloseFile(F);
ShowMessage('Input file has been saved to' + ' ' +  SaveFile.Text);

if (CheckBox14.Checked) and (Edit14.Text = '2') then
begin
  AssignFile(F2 , SaveFile.Text+'\'+Edit2.Text+'.relax.muminus2.pwi');
  ReWrite(F2);
  WriteLn(F2, '&CONTROL');
  WriteLn(F2, '  calculation =' + QuotedStr(ComboBox1.Text));
  WriteLn(F2, '  restart_mode = ' + QuotedStr(ComboBox2.Text));
  WriteLn(F2, '  outdir = ' + QuotedStr(Edit1.Text));
  WriteLn(F2, '  prefix = ' + QuotedStr(Edit2.Text));
  WriteLn(F2, '   max_seconds = ' + Edit3.Text);
  WriteLn(F2, '  pseudo_dir = ' + QuotedStr(Edit4.Text));
  WriteLn(F2, '/' );
  WriteLn(F2, '&SYSTEM');
  WriteLn(F2, '  ecutwfc = ' + Edit8.Text);
  WriteLn(F2, '  ecutrho = ' + Edit9.Text);



  if CheckBox1.Checked then
    begin
      WriteLn(F2, '  tot_charge = ' + ComboBox3.Text)
    end;
  if CheckBox2.Checked then
    begin
      WriteLn(F2, '  occupations = ' + QuotedStr(ComboBox4.Text));
      WriteLn(F2, '  smearing = ' + QuotedStr(ComboBox5.Text));
      WriteLn(F2, '  degauss = ' + Edit5.Text);
    end;
  if CheckBox3.Checked then
    begin
      WriteLn(F2, '  lda_plus_u = ' + QuotedStr('.true.'));
      WriteLn(F2, '  hubbard_u(1) = ' + Edit6.Text);
      if edit7.Text <> '' then
        WriteLn(F2, '  hubbard_u(2) = ' + Edit7.Text);
    end;
  WriteLn(F2, '  ntyp = ' + ' ' + inttostr(atomicspecies.Count));
  WriteLn(F2, '  nat = ' + ' ' + inttostr(lines - 8));
  WriteLn(F2, '  ibrav = 0');  
  WriteLn(F2, '/');
  WriteLn(F2, '&ELECTRONS');
  WriteLn(F2, '  mixing_beta = ' + Edit10.Text);
  if CheckBox4.Checked then
    begin
      WriteLn(F2, '  electron_maxstep = ' + Edit11.Text);
    end;
  if CheckBox5.Checked then
    begin
      WriteLn(F2, '  mixing_mode = ' + QuotedStr(ComboBox6.Text));
    end;
  WriteLn(F2, '/');
  WriteLn(F2, '&IONS');
  WriteLn(F2, '  ion_dynamics =' + QuotedStr('bfgs'));
  WriteLn(F2, '/');
  WriteLn(F2, '&CELL');
  WriteLn(F2, '/');
  WriteLn(F2, 'ATOMIC_SPECIES');
  if CheckBox6.Checked then
    begin
    if ComboBox8.Text[2] <> '.' then
      begin
      for i := 8 to lines-1 do
        begin
          if SplitString(XYZ2[i], ' ')[25] = '' then
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[24])
          else
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[25]);
        end;
      atomicspecieslines := atomicspecies1.Count;
      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox8.Text[1] + ComboBox8.Text[2] + '1' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass + ' ' + ComboBox8.Text);
          break
        end;
        
      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox8.Text[1] + ComboBox8.Text[2] + '2' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass + ' ' + ComboBox8.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox8.Text[1] + ComboBox8.Text[2] + '3' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass + ' ' + ComboBox8.Text);
          break
        end;
      end;
    if ComboBox8.Text[2] = '.' then
      begin
      for i := 8 to lines-1 do
        begin
          if SplitString(XYZ2[i], ' ')[25] = '' then
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[24])
          else
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[25]);
        end;
      atomicspecieslines := atomicspecies1.Count;
      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox8.Text[1] + '1' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass + ' ' + ComboBox8.Text);
          break
        end;
      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox8.Text[1] + '2' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass + ' ' + ComboBox8.Text);
          break
        end;
      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox8.Text[1] + '3' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass + ' ' + ComboBox8.Text);
          break
        end;
      end
  
    end;

  if CheckBox7.Checked then
    begin
    if ComboBox9.Text[2] <> '.' then
      begin
      for i := 8 to lines-1 do
        begin
          if SplitString(XYZ2[i], ' ')[25] = '' then
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[24])
          else
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[25]);
        end;
      atomicspecieslines := atomicspecies1.Count;
      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox9.Text[1] + ComboBox9.Text[2] + '1' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass2 + ' ' + ComboBox9.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox9.Text[1] + ComboBox9.Text[2] + '2' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass2 + ' ' + ComboBox9.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox9.Text[1] + ComboBox9.Text[2] + '3' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass2 + ' ' + ComboBox9.Text);
          break
        end;
      end;
    if ComboBox9.Text[2] = '.' then
      begin
      for i := 8 to lines-1 do
        begin
          if SplitString(XYZ2[i], ' ')[25] = '' then
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[24])
          else
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[25]);
        end;
      atomicspecieslines := atomicspecies.Count;
      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox9.Text[1] + '1' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass2 + ' ' + ComboBox9.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox9.Text[1] + '2' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass2 + ' ' + ComboBox9.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox9.Text[1] + '3' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass2 + ' ' + ComboBox9.Text);
          break
        end;
      end
  
    end;

  if CheckBox8.Checked then
    begin
    if ComboBox10.Text[2] <> '.' then
      begin
      for i := 8 to lines-1 do
        begin
          if SplitString(XYZ2[i], ' ')[25] = '' then
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[24])
          else
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[25]);
        end;
      atomicspecieslines := atomicspecies.Count;
      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox10.Text[1] + ComboBox10.Text[2] + '1' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass3 + ' ' + ComboBox10.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox10.Text[1] + ComboBox10.Text[2] + '2' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass3 + ' ' + ComboBox10.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox10.Text[1] + ComboBox10.Text[2] + '3' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass3 + ' ' + ComboBox10.Text);
          break
        end;
      end;
    if ComboBox10.Text[2] = '.' then
      begin
      for i := 8 to lines-1 do
        begin
          if SplitString(XYZ2[i], ' ')[25] = '' then
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[24])
          else
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[25]);
        end;
      atomicspecieslines := atomicspecies.Count;
      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox10.Text[1] + '1' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass3 + ' ' + ComboBox10.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox10.Text[1] + '2' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass3 + ' ' + ComboBox10.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox10.Text[1] + '3' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass3 + ' ' + ComboBox10.Text);
          break
        end;
      end
  
    end;

  if CheckBox9.Checked then
    begin
    if ComboBox11.Text[2] <> '.' then
      begin
      for i := 8 to lines-1 do
        begin
          if SplitString(XYZ2[i], ' ')[25] = '' then
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[24])
          else
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[25]);
        end;
      atomicspecieslines := atomicspecies.Count;
      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox11.Text[1] + ComboBox11.Text[2] + '1' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass4 + ' ' + ComboBox11.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox11.Text[1] + ComboBox11.Text[2] + '2' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass4 + ' ' + ComboBox11.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox11.Text[1] + ComboBox11.Text[2] + '3' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass4 + ' ' + ComboBox11.Text);
          break
        end;
      end;
    if ComboBox11.Text[2] = '.' then
      begin
      for i := 8 to lines-1 do
        begin
          if SplitString(XYZ2[i], ' ')[25] = '' then
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[24])
          else
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[25]);
        end;
      atomicspecieslines := atomicspecies.Count;
      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox11.Text[1] + '1' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass4 + ' ' + ComboBox11.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox11.Text[1] + '2' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass4 + ' ' + ComboBox11.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox11.Text[1] + '3' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass4 + ' ' + ComboBox11.Text);
          break
        end;
      end
  
    end;

  if CheckBox10.Checked then
    begin
    if ComboBox12.Text[2] <> '.' then
      begin
      for i := 8 to lines-1 do
        begin
          if SplitString(XYZ2[i], ' ')[25] = '' then
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[24])
          else
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[25]);
        end;
      atomicspecieslines := atomicspecies.Count;
      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox12.Text[1] + ComboBox12.Text[2] + '1' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass5 + ' ' + ComboBox12.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox12.Text[1] + ComboBox12.Text[2] + '2' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass5 + ' ' + ComboBox12.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox12.Text[1] + ComboBox12.Text[2] + '3' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass5 + ' ' + ComboBox12.Text);
          break
        end;
      end;
    if ComboBox12.Text[2] = '.' then
      begin
      for i := 8 to lines-1 do
        begin
          if SplitString(XYZ2[i], ' ')[25] = '' then
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[24])
          else
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[25]);
        end;
      atomicspecieslines := atomicspecies.Count;
      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox12.Text[1] + '1' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass5 + ' ' + ComboBox12.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox12.Text[1] + '2' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass5 + ' ' + ComboBox12.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox12.Text[1] + '3' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass5 + ' ' + ComboBox12.Text);
          break
        end;
      end
  
    end;

  if CheckBox11.Checked then
    begin
    if ComboBox13.Text[2] <> '.' then
      begin
      for i := 8 to lines-1 do
        begin
          if SplitString(XYZ2[i], ' ')[25] = '' then
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[24])
          else           
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[25]);
        end;
      atomicspecieslines := atomicspecies.Count;
      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox13.Text[1] + ComboBox13.Text[2] + '1' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass6 + ' ' + ComboBox13.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox13.Text[1] + ComboBox13.Text[2] + '2' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass6 + ' ' + ComboBox13.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox13.Text[1] + ComboBox13.Text[2] + '3' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass6 + ' ' + ComboBox13.Text);
          break
        end;
      end;
    if ComboBox12.Text[2] = '.' then
      begin
      for i := 8 to lines-1 do
        begin
          if SplitString(XYZ2[i], ' ')[25] = '' then
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[24])
          else
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[25]);
        end;
      atomicspecieslines := atomicspecies.Count;
      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox13.Text[1] + '1' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass6 + ' ' + ComboBox13.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox13.Text[1] + '2' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass6 + ' ' + ComboBox13.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox13.Text[1] + '3' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass6 + ' ' + ComboBox13.Text);
          break
        end;
      end
  
    end;

  if CheckBox12.Checked then
    begin
    if ComboBox14.Text[2] <> '.' then
      begin
      for i := 8 to lines-1 do
        begin
          if SplitString(XYZ2[i], ' ')[25] = '' then
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[24])
          else
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[25]);
        end;
      atomicspecieslines := atomicspecies.Count;
      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox14.Text[1] + ComboBox14.Text[2] + '1' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass7 + ' ' + ComboBox14.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox14.Text[1] + ComboBox14.Text[2] + '2' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass7 + ' ' + ComboBox14.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox14.Text[1] + ComboBox14.Text[2] + '3' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass7 + ' ' + ComboBox14.Text);
          break
        end;
      end;
    if ComboBox12.Text[2] = '.' then
      begin
      for i := 8 to lines-1 do
        begin
          if SplitString(XYZ2[i], ' ')[25] = '' then
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[24])
          else
            atomicspecies1.Add(SplitString(XYZ2[i], ' ')[25]);
        end;
      atomicspecieslines := atomicspecies.Count;
      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox14.Text[1] + '1' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass7 + ' ' + ComboBox14.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox14.Text[1] + '2' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass7 + ' ' + ComboBox14.Text);
          break
        end;

      for i := 0 to atomicspecieslines-1 do
        if atomicspecies1[i] = ComboBox14.Text[1] + '3' then
        begin    
          WriteLn(F2, atomicspecies1[i]  + ' ' + mass7 + ' ' + ComboBox14.Text);
          break
        end;
      end
  
    end;

  WriteLn(F2, 'K_POINTS automatic');
  WriteLn(F2, Edit12.text + ' 0 0 0 ');
  WriteLn(F2, 'CELL_PARAMETERS angstrom');
  for i := 2 to 4 do
    WriteLn(F2, XYZ2[i]);
  WriteLn(F2, 'ATOMIC_POSITIONS angstrom');
  for i := 8 to lines -1 do
    begin
      if SplitString(XYZ2[i], ' ')[25] = '' then
        thisatom := SplitString(XYZ2[i], ' ')[24]
      else
        thisatom := SplitString(XYZ2[i], ' ')[25];
      if SplitString(XYZ2[i], ' ')[5] = '' then
        thisatomx := SplitString(XYZ2[i], ' ')[4]
      else
        thisatomx := SplitString(XYZ2[i], ' ')[5];
      if SplitString(XYZ2[i], ' ')[14] = '' then
        thisatomy := SplitString(XYZ2[i], ' ')[13]
      else
        thisatomy := SplitString(XYZ2[i], ' ')[14];
      if SplitString(XYZ2[i], ' ')[23] = '' then
        thisatomz := SplitString(XYZ2[i], ' ')[22]
      else
        thisatomz := SplitString(XYZ2[i], ' ')[23];
      WriteLn(F2, thisatom + '   ' +  thisatomx + '   '  + thisatomy  + '   ' + thisatomz);
    end;
end;

CloseFile(F2);

end;

//This button opens up a file browser for searching .p1 files 
procedure TForm1.Button2Click(Sender: TObject);
begin
var
  openDialog : TOpenDialog;    // Open dialog variable
begin
  // Create the open dialog object - assign to our open dialog variable
  openDialog := TOpenDialog.Create(self);

  // Set up the starting directory to be the current one
  openDialog.InitialDir := GetCurrentDir;

  // Only allow existing files to be selected
  openDialog.Options := [ofFileMustExist];

  // Allow only .dpr and .pas files to be selected
  openDialog.Filter :=
    'p1 coordinate file|*.p1';

  // Select pascal files as the starting filter type
  openDialog.FilterIndex := 2;

  // Display the open file dialog
  if openDialog.Execute
  then Edit13.Text := openDialog.FileName;

  // Free up the dialog
  openDialog.Free;
end;
end;

//Enabling boxes for input 
procedure TForm1.CheckBox10Click(Sender: TObject);
begin
ComboBox12.Enabled := True
end;

procedure TForm1.CheckBox11Click(Sender: TObject);
begin
ComboBox13.Enabled := True
end;

procedure TForm1.CheckBox12Click(Sender: TObject);
begin
ComboBox14.Enabled := True
end;

procedure TForm1.CheckBox13Click(Sender: TObject);
begin
ComboBox7.Enabled := True;
end;

procedure TForm1.CheckBox14Click(Sender: TObject);
begin
Edit14.Enabled := True;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
ComboBox3.Enabled := True;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
ComboBox4.Enabled := True;
ComboBox5.Enabled := True;
Edit5.Enabled := True;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
Edit6.Enabled := True;
Edit7.Enabled := True;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
Edit11.Enabled := True
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
ComboBox6.Enabled := true
end;

procedure TForm1.CheckBox6Click(Sender: TObject);
begin
ComboBox8.Enabled := True
end;

procedure TForm1.CheckBox7Click(Sender: TObject);
begin
ComboBox9.Enabled := True
end;

procedure TForm1.CheckBox8Click(Sender: TObject);
begin
ComboBox10.Enabled := True
end;

procedure TForm1.CheckBox9Click(Sender: TObject);
begin
ComboBox11.Enabled := True
end;

end.
