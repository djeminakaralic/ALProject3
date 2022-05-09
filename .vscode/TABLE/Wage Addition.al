table 50032 "Wage Addition"
{
    Caption = 'Wage addition';
    DrillDownPageID = "Wage Addition";
    LookupPageID = "Wage Addition";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            var
                Txt001: Label '<Ne smijete mijenjati zakljucani red>';
                Txt002: Label '<Morate navesti tip dodatka>';
                WA: Record "Wage Addition";
                NextEntryNo: Integer;
                emp: Record "Employee";
                ConCat: Record "Contribution Category";
                ATCCon: Record "Contribution Category Conn.";
                ATCConRS: Record "Contribution Category Conn.";
                AddTaxes: Record "Contribution";
                AddTaxesRS: Record "Contribution";
                ATPercentRS: Decimal;
                ATPercent: Decimal;
                EmployeeContractLedger: Record "Employee Contract Ledger";
                SegmentationGroup: Record "Confidential Information";
                wb: Record "Work Booklet";
            begin
                IF emp.GET("Employee No.") THEN BEGIN
                    "First Name" := emp."First Name";
                    "Last Name" := emp."Last Name";
                    "Contribution Category Code" := emp."Contribution Category Code";
                END;

                wb.RESET;
                wb.SETFILTER("Employee No.", "Employee No.");
                wb.SETFILTER("Current Company", '%1', TRUE);
                IF wb.FINDLAST THEN BEGIN
                    "Starting Date" := wb."Starting Date"
                END;
                IF ((((TODAY - "Starting Date") DIV 30) < 6) AND (("Wage Addition Type" = 'INC') OR ("Wage Addition Type" = 'INC FIZ')
                   OR ("Wage Addition Type" = 'INC SFE') OR ("Wage Addition Type" = 'INC SME') OR ("Wage Addition Type" = 'INC MICRO')
                   OR ("Wage Addition Type" = 'INC PRAV')))
                THEN
                    ERROR('Zaposlenik nije ostvario pravo na incentive!!');
            end;
        }
        field(2; "Month of Wage"; Integer)
        {
            Caption = 'Month of Wage';
        }
        field(3; "Year of Wage"; Integer)
        {
            Caption = 'Year of Wage';
        }
        field(4; "Wage Addition Type"; Code[10])
        {
            Caption = 'Wage Addition Type';
            TableRelation = "Wage Addition Type";

            trigger OnValidate()
            var
                WAT: Record "Wage Addition Type";
            begin
                WAT.GET("Wage Addition Type");
                Description := WAT.Description;
                //Amount := WAT."Default Amount";
                VALIDATE("Amount to Pay", WAT."Default Amount");
                VALIDATE(Taxable, WAT.Taxable);
                VALIDATE("Use", WAT.Use);
                VALIDATE(Regres, WAT.Regres);
                VALIDATE(Incentive, WAT.Incentive);
                VALIDATE("Use Apportionment Account", WAT."Use Apportionment Account");
            end;
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(8; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(9; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
        }
        field(99; "Add. Taxable"; Boolean)
        {
            Caption = 'Add. Taxable';

            trigger OnValidate()
            var
                Txt001: Label '<Ne smijete mijenjati zakljucani red>';
                Txt002: Label '<Morate navesti tip dodatka>';
                WA: Record "Wage Addition";
                NextEntryNo: Integer;
                emp: Record "Employee";
                ConCat: Record "Contribution Category";
                ATCCon: Record "Contribution Category Conn.";
                ATCConRS: Record "Contribution Category Conn.";
                AddTaxes: Record "Contribution";
                AddTaxesRS: Record "Contribution";
                ATPercentRS: Decimal;
                ATPercent: Decimal;
                EmployeeContractLedger: Record "Employee Contract Ledger";
                SegmentationGroup: Record "Confidential Information";
                wb: Record "Work Booklet";
            begin
                IF "Add. Taxable" = TRUE THEN BEGIN
                    IF Rec."Contribution Category Code" <> 'FBIHRS' THEN
                        ConCat.SETFILTER(Code, '%1', 'FBIH')
                    ELSE
                        ConCat.SETFILTER(Code, '%1', Rec."Contribution Category Code");
                    IF ConCat.FINDSET THEN BEGIN
                        ConCat.CALCFIELDS("From Brutto");
                        Rec."Calculated Amount Brutto" := (Rec."Amount to Pay") / ((1 - ConCat."From Brutto" / 100));
                        Rec.Tax := 0;

                        Rec.Amount := Rec."Amount to Pay";
                        Rec.Brutto := Rec."Calculated Amount Brutto";
                        Rec.Taxable := TRUE;
                    END
                    //END
                    ELSE BEGIN
                        Rec.Amount := Rec."Amount to Pay";
                    END
                END
                ELSE BEGIN
                    Rec."Calculated Amount Brutto" := 0;
                    Rec.Tax := 0;
                    Rec.Amount := Rec."Amount to Pay";
                    Rec.Brutto := Rec.Amount;
                END;

            end;
        }
        field(100; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(101; Locked; Boolean)
        {
            Caption = 'Locked';
        }
        field(102; "Wage Header No."; Code[10])
        {
            Caption = 'Wage Header No.';
        }
        field(103; "Wage Header Entry No."; Integer)
        {
            Caption = 'Wage Header Entry No.';
        }
        field(104; "Calculated Amount"; Decimal)
        {
            Caption = 'Calculated Amount';
        }
        field(105; Taxable; Boolean)
        {
            Caption = 'Taxable';

            trigger OnValidate()
            var
                Txt001: Label '<Ne smijete mijenjati zakljucani red>';
                Txt002: Label '<Morate navesti tip dodatka>';
                WA: Record "Wage Addition";
                NextEntryNo: Integer;
                emp: Record "Employee";
                ConCat: Record "Contribution Category";
                ATCCon: Record "Contribution Category Conn.";
                ATCConRS: Record "Contribution Category Conn.";
                AddTaxes: Record "Contribution";
                AddTaxesRS: Record "Contribution";
                ATPercentRS: Decimal;
                ATPercent: Decimal;
                EmployeeContractLedger: Record "Employee Contract Ledger";
                SegmentationGroup: Record "Confidential Information";
                wb: Record "Work Booklet";
            begin
                IF Taxable = TRUE THEN BEGIN
                    IF Rec."Contribution Category Code" <> 'FBIHRS' THEN
                        ConCat.SETFILTER(Code, '%1', 'FBIH')
                    ELSE
                        ConCat.SETFILTER(Code, '%1', Rec."Contribution Category Code");
                    IF ConCat.FINDSET THEN BEGIN

                        Rec."Calculated Amount Brutto" := (Rec."Amount to Pay") / ((1 - ConCat."From Brutto" / 100) * 0.9);
                        Rec.Tax := ((1 - ConCat."From Brutto" / 100) * Rec."Calculated Amount Brutto") - Rec."Amount to Pay";

                        Rec.Amount := Rec."Amount to Pay" + Rec.Tax;
                        Rec.Brutto := Rec."Calculated Amount Brutto";
                    END
                    //END
                    ELSE BEGIN
                        Rec.Amount := Rec."Amount to Pay";
                    END
                END
                ELSE BEGIN
                    Rec."Calculated Amount Brutto" := 0;
                    Rec.Tax := 0;
                    Rec.Amount := Rec."Amount to Pay";
                    Rec.Brutto := Rec.Amount;
                END;

            end;
        }
        field(106; "Calculated Amount Brutto"; Decimal)
        {
        }
        field(107; "Amount to Pay"; Decimal)
        {
            Caption = 'Calculated Amount';

            trigger OnValidate()
            var
                Txt001: Label '<Ne smijete mijenjati zakljucani red>';
                Txt002: Label '<Morate navesti tip dodatka>';
                WA: Record "Wage Addition";
                NextEntryNo: Integer;
                emp: Record "Employee";
                ConCat: Record "Contribution Category";
                ATCCon: Record "Contribution Category Conn.";
                ATCConRS: Record "Contribution Category Conn.";
                AddTaxes: Record "Contribution";
                AddTaxesRS: Record "Contribution";
                ATPercentRS: Decimal;
                ATPercent: Decimal;
                EmployeeContractLedger: Record "Employee Contract Ledger";
                SegmentationGroup: Record "Confidential Information";
                wb: Record "Work Booklet";

            begin
                IF ((Rec.Taxable = TRUE) OR (Rec."Add. Taxable" = TRUE)) THEN BEGIN
                    ConCat.SETFILTER(Code, '%1', Rec."Contribution Category Code");
                    IF ConCat.FINDSET THEN BEGIN
                        ConCat.CALCFIELDS("From Brutto");
                        Rec."Calculated Amount Brutto" := (Rec."Amount to Pay") / ((1 - ConCat."From Brutto" / 100));
                        Rec.Tax := ((1 - ConCat."From Brutto" / 100) * Rec."Calculated Amount Brutto") - Rec."Amount to Pay";
                        Rec.Amount := Rec."Amount to Pay" + Rec.Tax;
                        Rec.Brutto := Rec."Calculated Amount Brutto";
                        AddTaxes.RESET;
                        ATCCon.SETFILTER("Category Code", '%1', Rec."Contribution Category Code");
                        IF ATCCon.FINDFIRST THEN
                            REPEAT
                                /*   IF ((Rec."Contribution Category Code"='FBIHRS') OR (Rec."Contribution Category Code"='BDPIORS')) THEN BEGIN
                                    IF ATCConRS.GET('RS', Rec."Contribution Category Code") THEN
                                      ATPercentRS:= ATCConRS.Percentage/100;
                                 END;*/
                                ATPercent := ATCCon.Percentage / 100;
                                IF ATCCon."Contribution Code" = 'D-PIO-IZ' THEN
                                    "PIO From" := ROUND(Rec.Brutto * ATCCon.Percentage / 100, 0.01, '=');

                                IF ATCCon."Contribution Code" = 'D-PIO-NA' THEN
                                    "PIO On" := ROUND(Rec.Brutto * ATCCon.Percentage / 100, 0.01, '=');

                                IF ATCCon."Contribution Code" = 'D-NEZAP-IZ' THEN
                                    "Unemployment From" := ROUND(Rec.Brutto * ATCCon.Percentage / 100, 0.01, '=');

                                IF ATCCon."Contribution Code" = 'D-NEZAP-NA' THEN
                                    "Unemployment On" := ROUND(Rec.Brutto * ATCCon.Percentage / 100, 0.01, '=');

                                IF ATCCon."Contribution Code" = 'D-ZDRAV-IZ' THEN
                                    "Health From" := ROUND(Rec.Brutto * ATCCon.Percentage / 100, 0.01, '=');

                                IF ATCCon."Contribution Code" = 'D-ZDRAV-NA' THEN
                                    "Health On" := ROUND(Rec.Brutto * ATCCon.Percentage / 100, 0.01, '=');

                                IF ATCCon."Contribution Code" = 'P-VOD' THEN
                                    "Water Fee" := ROUND(Rec."Amount to Pay" * ATCCon.Percentage / 100, 0.01, '=');

                                IF ATCCon."Contribution Code" = 'P-ELNEP' THEN
                                    "Disaster Fee" := ROUND(Rec."Amount to Pay" * ATCCon.Percentage / 100, 0.01, '=');

                                "Total From" := "PIO From" + "Health From" + "Unemployment From";
                                "Total On" := "PIO On" + "Health On" + "Unemployment On";
                                "Total Cost" := "Total From" + "Total On" + "Disaster Fee" + "Water Fee" + "Amount to Pay" + Tax;
                            //ATAmount := ROUND(Rec.Brutto * ATPercent,0.01,'>');
                            // ATAmountRS := ROUND(Rec.Brutto * ATPercentRS,0.01,'=');
                            UNTIL ATCCon.NEXT = 0;
                    END
                    //END
                    ELSE BEGIN
                        Rec.Amount := Rec."Amount to Pay";
                    END
                END
                ELSE BEGIN
                    Rec."Calculated Amount Brutto" := 0;
                    Rec.Tax := 0;
                    Rec.Amount := Rec."Amount to Pay";
                    Rec.Brutto := Rec.Amount;
                END;

            end;
        }
        field(108; Tax; Decimal)
        {
        }
        field(109; "Contribution Category Code"; Code[10])
        {
        }
        field(111; "Use"; Boolean)
        {
            Caption = 'Use';
        }
        field(112; "Wage Calculation Entry No."; Code[20])
        {
            Caption = 'No.';
        }
        field(113; Calculated; Boolean)
        {
            Caption = 'Calculated';
        }
        field(114; Regres; Boolean)
        {
        }
        field(115; "Use Apportionment Account"; Boolean)
        {
            Caption = 'Use Apportionment Account';
        }
        field(116; "Closing Date"; Date)
        {
            Caption = 'Closing Date';
        }
        field(117; Incentive; Boolean)
        {
        }
        field(118; Brutto; Decimal)
        {
        }
        field(119; "PIO From"; Decimal)
        {
            Caption = 'PIO From';
        }
        field(120; "Health From"; Decimal)
        {
            Caption = 'Health From';
        }
        field(121; "Unemployment From"; Decimal)
        {
            Caption = 'Unemployment From';
        }
        field(122; "Total From"; Decimal)
        {
            Caption = 'Total From';
        }
        field(123; "PIO On"; Decimal)
        {
            Caption = 'PIO On';
        }
        field(124; "Health On"; Decimal)
        {
            Caption = 'Health On';
        }
        field(125; "Unemployment On"; Decimal)
        {
            Caption = 'Unemployment On';
        }
        field(126; "Total On"; Decimal)
        {
            Caption = 'Total On';
        }
        field(127; "Water Fee"; Decimal)
        {
            Caption = 'Water Fee';
        }
        field(128; "Disaster Fee"; Decimal)
        {
            Caption = 'Disaster Fee';
        }
        field(129; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
        }
        field(130; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
        }
        field(131; "Payment Year"; Integer)
        {
            Caption = 'Payment Year';
        }
        field(132; "Payment Moth"; Integer)
        {
            Caption = 'Payment Month';
        }
        field(133; Gender; enum "Employee Gender")
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee.Gender WHERE("No." = FIELD("Employee No.")));
            Caption = 'Gender';


        }
        field(134; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(135; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(136; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Active,Inactive,Unpaid,Terminated,On boarding,Practicians,Trainee';
            OptionMembers = Active,Inactive,Unpaid,Terminated,"On boarding",Practicians,Trainee;
        }
        field(50295; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            Editable = false;
            FieldClass = Normal;
        }
        field(50299; "B-1"; Code[10])
        {
            Caption = 'B-1';
            Editable = false;
            FieldClass = Normal;
        }
        field(50300; "B-1 Description"; Text[250])
        {
            Caption = 'B-1 Description';
            Editable = false;
            FieldClass = Normal;
        }
        field(50301; "B-1 (with regions)"; Code[10])
        {
            Caption = 'B-1 (with regions)';
            Editable = false;
            FieldClass = Normal;
        }
        field(50302; "B-1 (with regions) Description"; Text[250])
        {
            Caption = 'B-1 (with regions) Description';
            Editable = false;
            FieldClass = Normal;
        }
        field(50303; Stream; Code[10])
        {
            Caption = 'Stream';
            Editable = false;
            FieldClass = Normal;
        }
        field(50304; "Stream Description"; Text[250])
        {
            Caption = 'Stream Description';
            Editable = false;
            FieldClass = Normal;
        }
        field(50316; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
        }
        field(50317; "Position Code"; Code[20])
        {
            Caption = 'Position Code';

            trigger OnValidate()
            begin
                /*CALCFIELDS("Position Description","Minimal Education Level");
                
                   position.SETFILTER(Code,"Position Code");
                   IF position.FINDFIRST THEN BEGIN
                     "Position Benef".SETFILTER("Position Code","Position Code");
                     IF "Position Benef".FINDFIRST THEN BEGIN
                       REPEAT
                     MAI.INIT;
                     MAI."Employee No.":="Employee No.";
                     MAI."Position Code":="Position Code";
                     MAI."Misc. Article Code":="Position Benef".Code;
                     MAI.Description:="Position Benef".Description;
                     MAI.Amount:="Position Benef".Amount;
                     MAI."Emp. Contract Ledg. Entry No.":=Rec."No.";
                     MAI."From Date":="Starting Date";
                     MAI.INSERT;
                     UNTIL "Position Benef".NEXT=0;
                     END
                END;
                position.SETFILTER("Org. Structure",'%1', "Org. Structure");
                position.SETFILTER(Code,'%1',"Position Code");
                position.SETFILTER("Position ID",'%1',"Position ID");
                IF position.FINDFIRST THEN
                  BEGIN
                    position."Employee No.":="Employee No.";
                    position."Employee Full Name":= "Employee Name";
                    position.MODIFY;
                  END;*/

            end;
        }
        field(50318; "Position ID"; Code[10])
        {
            Caption = 'Position ID';
        }
        field(50319; "Position Description"; Text[250])
        {
            Caption = 'Position Description';
            Editable = false;
            FieldClass = Normal;
        }
        field(50320; "Management Level"; Code[10])
        {
            Caption = 'Management Level';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Employee No.", "Year of Wage", "Month of Wage", "Wage Addition Type")
        {
            SumIndexFields = Amount;
        }
        key(Key3; "Wage Addition Type", "Year of Wage", "Month of Wage", "Employee No.")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //IF xRec.Locked OR xRec.Calculated  THEN ERROR(Txt001);
    end;

    trigger OnInsert()
    begin
        NextEntryNo := 0;
        IF WA.FIND('+') THEN
            NextEntryNo := WA."Entry No.";

        NextEntryNo += 1;
        "Entry No." := NextEntryNo;
        /* ĐK IF ((((TODAY - "Starting Date") DIV 30) < 6) AND (("Wage Addition Type" = 'INC') OR ("Wage Addition Type" = 'INC FIZ')
           OR ("Wage Addition Type" = 'INC SFE') OR ("Wage Addition Type" = 'INC SME') OR ("Wage Addition Type" = 'INC MICRO')
           OR ("Wage Addition Type" = 'INC PRAV')))
        THEN
             ERROR('Zaposlenik nije ostvario pravo na incentive!!');*/
    end;

    trigger OnModify()
    begin
        //IF xRec.Locked xRec.Calculated  THEN ERROR(Txt001);
    end;

    trigger OnRename()
    begin
        IF xRec.Locked THEN ERROR(Txt001);
    end;

    var
        Txt001: Label '<Ne smijete mijenjati zakljucani red>';
        Txt002: Label '<Morate navesti tip dodatka>';
        WA: Record "Wage Addition";
        NextEntryNo: Integer;
        emp: Record "Employee";
        ConCat: Record "Contribution Category";
        ATCCon: Record "Contribution Category Conn.";
        ATCConRS: Record "Contribution Category Conn.";
        AddTaxes: Record "Contribution";
        AddTaxesRS: Record "Contribution";
        ATPercentRS: Decimal;
        ATPercent: Decimal;
        EmployeeContractLedger: Record "Employee Contract Ledger";
        SegmentationGroup: Record "Confidential Information";
        wb: Record "Work Booklet";
}

