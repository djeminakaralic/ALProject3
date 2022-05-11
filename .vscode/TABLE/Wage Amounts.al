table 50015 "Wage Amounts"
{
    Caption = 'Wage amount';

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';

            trigger OnValidate()
            begin
                IF emp.GET("Employee No.") THEN BEGIN
                    "First Name" := emp."First Name";
                    "Last Name" := emp."Last Name";
                    //     "Department code" := emp."Department code";
                END;
            end;
        }
        field(2; "Wage Amount"; Decimal)
        {
            Caption = 'Wage Amount';

            trigger OnValidate()
            begin
                IF ("Wage Amount" <> 0) AND "Net Basis Includes Tax" THEN
                    ERROR(Text002);
                "Wage Base 2" := "Wage Amount";
            end;
        }
        field(3; "Net Amount"; Boolean)
        {
            Caption = 'Net Amount';
        }
        field(4; "Old Amount"; Decimal)
        {
            Caption = 'Old Amount';
            Description = 'Temp';
        }
        field(5; "Net Amount Including Tax"; Decimal)
        {
            Caption = 'Net Amount Including Tax';

            trigger OnValidate()
            var
                Empl: Record "Employee";
                TaxClass: Record "Tax Class";
            begin
                IF "Net Basis Includes Tax" AND "Net Amount" THEN BEGIN
                    Empl.GET("Employee No.");
                    //ĐK TaxClass.SETRANGE("Entity Code", Empl."Entity Code");
                    TaxClass.SETRANGE(Active, TRUE);
                    TaxClass.SETFILTER("Valid From Amount", '<=%1', "Net Amount Including Tax");
                    TaxClass.SETFILTER("Valid To Amount", '>=%1', "Net Amount Including Tax");
                    /*  IF TaxClass.FIND('-') THEN
                       /*   "Wage Amount" := (("Net Amount Including Tax" - Empl."Tax Deduction Amount")
                                           / (1 - TaxClass.Percentage / 100))
                                           + Empl."Tax Deduction Amount"*/
                    //ELSE
                    //  ERROR(Text004);
                END
                ELSE
                    ERROR(Text003);
                MESSAGE(FORMAT("Net Amount Including Tax"));
                //   MESSAGE(FORMAT(Empl."Tax Deduction Amount"));
            end;
        }
        field(6; "Net Basis Includes Tax"; Boolean)
        {
            Caption = 'Net Basis Includes Tax';

            trigger OnValidate()
            begin
                IF ("Wage Amount" <> 0) AND "Net Basis Includes Tax" THEN
                    ERROR(Text002);
            end;
        }
        field(7; "Net Amount 2"; Decimal)
        {
            Caption = 'Net Amount 2';
        }
        field(8; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(9; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
        }
        field(50126; "Department code"; Code[10])
        {
            Caption = 'Department code';
            FieldClass = Normal;
        }
        field(50127; Coefficient; Decimal)
        {
            Caption = 'Coefficient';

            trigger OnValidate()
            begin
                WageSetup.GET;
                IF WageSetup."Wage Base" <> 0 THEN
                    "Wage Amount" := WageSetup."Wage Base" * Coefficient;
                MODIFY;
            end;
        }
        field(50128; "Two Part Wage"; Boolean)
        {
            Caption = 'Two Part Wage';

            trigger OnValidate()
            begin
                WageSetup.GET;
                IF "Two Part Wage" THEN BEGIN
                    //  "Hour Pool" := AbsenceFill.GetHourPool(DATE2DMY(CALCDATE('0D', WORKDATE), 2), DATE2DMY(CALCDATE('0D', WORKDATE), 3), WageSetup."Hours in Day");
                    "Wage Base 2" := "Wage Amount";
                END
                ELSE BEGIN
                    "Wage Base 1" := 0;
                    "Wage Base 2" := 0;
                    "Days With Wage Base 1" := 0;
                    "Days With Wage Base 2" := 0;
                END;
            end;
        }
        field(50129; "Wage Base 1"; Decimal)
        {
            Caption = 'Coefficient';

            trigger OnValidate()
            begin
                WageSetup.GET;
                VALIDATE("Wage Amount 1", (("Wage Base 1" / "Hour Pool") *
                ("Days With Wage Base 1" * WageSetup."Hours in Day")));
            end;
        }
        field(50130; "Wage Base 2"; Decimal)
        {
            Caption = 'Coefficient';

            trigger OnValidate()
            begin
                WageSetup.GET;
                VALIDATE("Wage Amount 2", (("Wage Base 2" / "Hour Pool") * ("Days With Wage Base 2" * WageSetup."Hours in Day")));
            end;
        }
        field(50131; "Days With Wage Base 1"; Integer)
        {
            Caption = 'Days With Wage Base 1';

            trigger OnValidate()
            begin

                WageSetup.GET;
                VALIDATE("Wage Amount 1", (("Wage Base 1" / "Hour Pool") * ("Days With Wage Base 1" * WageSetup."Hours in Day")));
            end;
        }
        field(50132; "Days With Wage Base 2"; Integer)
        {
            Caption = 'Days With Wage Base 1';

            trigger OnValidate()
            begin
                WageSetup.GET;

                VALIDATE("Wage Amount 2", (("Wage Base 2" / "Hour Pool") * ("Days With Wage Base 2" * WageSetup."Hours in Day")));
            end;
        }
        field(50133; "Wage Amount 1"; Decimal)
        {
            Caption = 'Wage Amount';

            trigger OnValidate()
            begin
                IF ("Wage Amount" <> 0) AND "Net Basis Includes Tax" THEN
                    ERROR(Text002);


                "Wage Amount" := "Wage Amount 1" + "Wage Amount 2";
            end;
        }
        field(50134; "Wage Amount 2"; Decimal)
        {
            Caption = 'Wage Amount';

            trigger OnValidate()
            begin
                IF ("Wage Amount" <> 0) AND "Net Basis Includes Tax" THEN
                    ERROR(Text002);

                "Wage Amount" := "Wage Amount 1" + "Wage Amount 2";
            end;
        }
        field(50135; "Hour Pool"; Integer)
        {
            Caption = 'Hour Pool';
        }
    }

    keys
    {
        key(Key1; "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        IF xRec."Wage Amount" <> Rec."Wage Amount" THEN
            IF NOT CONFIRM(Text001) THEN
                Rec."Wage Amount" := xRec."Wage Amount";
    end;

    var
        Text001: Label 'Do you want to change wage amount?';
        Text002: Label 'Molimo unesite Neto iznos sa porezom.';
        Text003: Label 'Molimo unesite polje Iznos Plate.';
        Text004: Label 'Porezni razred nije definisan';
        emp: Record "Employee";
        // AbsenceFill: Codeunit "50003";
        WageSetup: Record "Wage Setup";
}

