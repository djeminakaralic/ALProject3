table 50044 "Training Time Entry"
{
    Caption = 'Evidencija održavanja obuka/edukacija';
    LookupPageId = "Training Time Entries";
    DrillDownPageId = "Training Time Entries";

    fields
    {

        field(1; Code; Integer)
        {
            AutoIncrement = true;
            Caption = 'Code';


        }
        field(2; Code2; Integer)
        {
            Caption = 'Training catalogue code';
            TableRelation = "Training Catalogue".Code;
        }
        field(3; Name; Text[250])
        {
            Caption = 'Traning Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Training Catalogue".Name where(Code = field(Code2)));

        }
        field(4; Type; Option)
        {
            OptionMembers = Interni,Eksterni;
            Caption = 'Type';
            FieldClass = FlowField;
            CalcFormula = lookup("Training Catalogue".Type where(Code = field(Code2)));

        }
        field(5; Location; Text[250])
        {
            Caption = 'Location';
            FieldClass = FlowField;
            CalcFormula = lookup("Training Catalogue".Location where(Code = field(Code2)));

        }
        field(6; Month; Text[50])
        {
            Caption = 'Month';
            FieldClass = FlowField;
            CalcFormula = lookup("Training Catalogue".Month where(Code = field(Code2)));
        }

        field(8; "Start date"; Date)
        {
            Caption = 'Start date';

        }
        field(9; "End date"; Date)
        {
            Caption = 'End date';
            trigger OnValidate()
            begin
                if ("End date" < "Start date") then
                    Error('"End date" can not be before "Start date."');
            end;

        }
        field(10; Status; Option)
        {
            OptionMembers = "In progress",Finished,"In preparation";
            Caption = 'Status';

        }
        field(11; "Number of people"; Integer)
        {
            Caption = 'Number of planed people';

        }

        field(12; "Travel cost ino"; Decimal)
        {

        }
        field(13; "Travel cost home"; Decimal)
        {

        }
        field(14; "Daily rate home"; Decimal)
        {

        }
        field(15; "Daily rate ino"; Decimal)
        {

        }
        field(16; "Number of days"; Integer)
        {

        }
        field(17; "Daily rate home SUM"; Decimal)
        {


        }
        field(18; "Daily rate ino SUM"; Decimal)
        {


        }
        field(19; "Kotizacija"; Decimal)
        {

        }
        field(20; "Hours"; Integer)
        {

        }
        field(21; "Number of people attended"; Integer)
        {
            Caption = 'Number of people that attended';
            FieldClass = FlowField;
            CalcFormula = count("Employee Training Ledger" where(Code2Entry = field(Code)));
        }
        field(22; TypeOF; code[20])
        {
            Caption = 'Location';
            /*FieldClass = FlowField;
            CalcFormula = lookup("Training Catalogue".TypeOF where(Code = field(Code2)));*/

        }

    }
    keys
    {
        key(Key1; Code)
        {
        }
    }

}