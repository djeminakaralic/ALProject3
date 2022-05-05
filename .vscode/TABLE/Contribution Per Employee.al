table 50019 "Contribution Per Employee"
{
    // //

    Caption = 'Contribution per Employee';

    fields
    {
        field(1;"Employee No.";Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
        field(2;"Entry No.";Integer)
        {
            Caption = 'Entry No.';
        }
        field(3;"Wage Header No.";Code[10])
        {
            Caption = 'Wage Header No.';
        }
        field(4;"Wage Calc No.";Code[20])
        {
            Caption = 'Wage Calc No.';
        }
        field(5;"Contribution Code";Code[10])
        {
            Caption = 'Additional Tax Code';
        }
        field(6;"Amount From Wage";Decimal)
        {
            Caption = 'Amount From Wage';
        }
        field(7;"Amount Over Wage";Decimal)
        {
            Caption = 'Amount Over Wage';
        }
        field(8;Basis;Decimal)
        {
            Caption = 'Basis';
        }
        field(9;"Amount Over Neto";Decimal)
        {
            Caption = 'Amount Over Neto';
        }
        field(11;"Global Dimension 1 Code";Code[20])
        {
            Caption = 'Global Dimension 1 Code';
        }
        field(12;"Global Dimension 2 Code";Code[20])
        {
            Caption = 'Global Dimension 2 Code';
        }
        field(197;"Shortcut Dimension 4 Code";Code[10])
        {
        }
        field(198;"Wage Calculation Type";Option)
        {
            Caption = 'Wage Calculation Type';
            OptionCaption = 'Regular,Temporary Service Contracts-Residents,Temporary Service Contracts-No Residents,Author Contracts,Additions';
            OptionMembers = Regular,"Temporary Service Contracts-Residents","Temporary Service Contracts-No Residents","Author Contracts",Additions;
        }
        field(199;"Amount On Wage";Decimal)
        {
            Caption = 'Amount On Wage';
            FieldClass = Normal;
        }
        field(200;Percentage;Decimal)
        {
        }
        field(201;"Reported Amount From Wage";Decimal)
        {
        }
        field(202;"Reported Amount On Wage";Decimal)
        {
        }
        field(203;"Contribution Category Code";Code[10])
        {
            Caption = 'Additional Tax Category Code';
            TableRelation = "Contribution Category".Code;
        }
        field(204;"Wage Calculation Entry No.";Code[20])
        {
            Caption = 'No.';
        }
        field(205;"Reported Amount On Netto";Decimal)
        {
        }
        field(206;M;Code[10])
        {
            FieldClass = Normal;
        }
        field(207;Calculated;Boolean)
        {
            Caption = 'Calculated';
        }
        field(208;"Payment Date";Date)
        {
            Caption = 'Payment Date';
        }
    }

    keys
    {
        key(Key1;"Wage Header No.","Employee No.","Wage Calc No.","Contribution Code")
        {
        }
        key(Key2;"Contribution Code")
        {
        }
        key(Key3;"Wage Header No.","Entry No.","Contribution Code","Employee No.")
        {
            SumIndexFields = "Amount From Wage","Amount Over Wage","Amount Over Neto","Reported Amount From Wage";
        }
        key(Key4;"Wage Header No.","Entry No.","Contribution Code","Employee No.",Calculated)
        {
            SumIndexFields = "Amount From Wage","Amount Over Wage","Amount Over Neto","Reported Amount From Wage";
        }
    }

    fieldgroups
    {
    }
}

