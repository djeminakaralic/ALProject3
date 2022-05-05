table 50026 "Reduction Types"
{
    Caption = 'Reduction types';

    fields
    {
        field(1;"Code";Code[10])
        {
            Caption = 'Code';
        }
        field(2;Description;Text[30])
        {
            Caption = 'Description';
        }
        field(3;AmountIsPercentage;Boolean)
        {
            Caption = 'AmountIsPercentage';
        }
        field(4;AmountWithoutLimit;Boolean)
        {
            Caption = 'Amount has no limit';
        }
        field(5;"G/L Account";Code[20])
        {
            Caption = 'G/L Account';
            TableRelation = "G/L Account";
        }
        field(6;"Separate Payment";Boolean)
        {
            Caption = 'Separate Payment';
        }
        field(107;"Bal. G/L Account";Code[20])
        {
            Caption = 'G/L Account';
            TableRelation = "G/L Account";
        }
        field(108;"Transit  Account";Code[20])
        {
            Caption = 'Transit Account';
            TableRelation = "G/L Account";
        }
        field(109;"Transit  Account 2";Code[20])
        {
            Caption = 'Transit Account 2';
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1;"Code")
        {
        }
    }

    fieldgroups
    {
    }
}

