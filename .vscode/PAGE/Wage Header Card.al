page 50017 "Wage Header Card"
{
    Caption = 'Wage Header Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Wage Header";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(Basic)
            {
                Caption = 'Basic';
                field("No."; "No.")
                {
                    ApplicationArea = all;
                }
                field("Year Of Wage"; "Year Of Wage")
                {
                    ApplicationArea = all;
                }
                field("Month Of Wage"; "Month Of Wage")
                {
                    ApplicationArea = all;
                }
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Wage Calculation Type"; "Wage Calculation Type")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field("Date Of Calculation"; "Date Of Calculation")
                {
                    ApplicationArea = all;
                }
                field("Year of Calculation"; "Year of Calculation")
                {
                    ApplicationArea = all;
                }
                field("Month of Calculation"; "Month of Calculation")
                {
                    ApplicationArea = all;
                }
                field("Average Wage"; "Average Wage")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        WageSetup.GET;

                        //emp.SETFILTER("Contribution Category Code",'%1','FBiH' );
                        //emp.SETFILTER("For Calculation",'%1',TRUE );
                        //IF emp.FIND('-')THEN REPEAT

                        IF cpe1.FINDLAST THEN No := INCSTR(cpe1."Wage Calc No.");
                        cpe1.SETRANGE("Wage Header No.", xRec."No.");
                        cpe1.SETRANGE("Wage Calculation Type", 0);
                        IF cpe1.FIND('+')
                        THEN BEGIN
                            CALCFIELDS(Employees);
                            CALCFIELDS("Disabled Employees");


                            cpe1.SETFILTER("Wage Header No.", '%1', xRec."No.");
                            //cpe1.SETFILTER("Wage Calc No.",'%1',"No.");
                            cpe1.SETFILTER("Contribution Code", '%1', WageSetup."Invalid Fund Contribution Code");
                            IF NOT cpe1.FINDFIRST THEN BEGIN
                                cpe1.INIT;
                                cpe1."Wage Header No." := xRec."No.";
                                cpe1."Wage Calc No." := No;
                                cpe1."Employee No." := '';
                                cpe1."Contribution Code" := WageSetup."Invalid Fund Contribution Code";
                                cpe1."Amount Over Wage" := ("Average Wage" * WageSetup."Invaalid Fund %" / 100) * ((Employees DIV WageSetup."No. Of Employees") - "Disabled Employees");
                                cpe1."Amount Over Neto" := ("Average Wage" * WageSetup."Invaalid Fund %" / 100) * ((Employees DIV WageSetup."No. Of Employees") - "Disabled Employees");
                                cpe1.Basis := "Average Wage";
                                WageSetup.GET;
                                cpe1."Global Dimension 1 Code" := WageSetup."Global Dimension 1 Code Fund";
                                cpe1.INSERT;
                            END
                            ELSE BEGIN
                                cpe1.SETFILTER("Employee No.", '%1', '');
                                cpe1.SETFILTER("Wage Header No.", '%1', xRec."No.");
                                cpe1.SETFILTER("Contribution Code", '%1', WageSetup."Invalid Fund Contribution Code");
                                IF cpe1.FIND('-') THEN BEGIN
                                    cpe1."Amount Over Wage" := ("Average Wage" * WageSetup."Invaalid Fund %" / 100) * ((Employees DIV WageSetup."No. Of Employees") - "Disabled Employees");
                                    cpe1."Amount Over Neto" := ("Average Wage" * WageSetup."Invaalid Fund %" / 100) * ((Employees DIV WageSetup."No. Of Employees") - "Disabled Employees");
                                    cpe1.Basis := "Average Wage";
                                    cpe1.MODIFY;
                                END;
                            END;
                        END;

                        wve2.SETFILTER("Document No.", '%1', xRec."No.");
                        wve2.SETFILTER("Contribution Type", '%1', WageSetup."Invalid Fund Contribution Code");
                        IF NOT wve2.FINDFIRST THEN BEGIN
                            IF wve.FINDLAST THEN ValueEntryNo := wve."Entry No." + 1;
                            wve.INIT;
                            wve."Entry No." := ValueEntryNo;
                            wve."Employee No." := '';
                            wve."Document No." := xRec."No.";
                            wve.Description := 'Doprinos za fond solidarnosti';
                            wve."Wage Posting Group" := 'FBiH';
                            wve."Wage Ledger Entry No." := WLE."Entry No.";
                            wve."User ID" := USERID;
                            wve."Global Dimension 1 Code" := WageSetup."Global Dimension 1 Code Fund";
                            //WVE."Global Dimension 2 Code":=WLE."Global Dimension 2 Code";
                            //WVE."Shortcut Dimension 4 Code":=WLE."Shortcut Dimension 4 Code";
                            wve."Document Date" := TODAY;
                            wve."Posting Date" := af.GetMonthRange(xRec."Month Of Wage", xRec."Year Of Wage", FALSE);
                            ;
                            wve."Contribution Type" := WageSetup."Invalid Fund Contribution Code";
                            wve."Post Code" := emp."Post Code";
                            wve.Basis := xRec."Average Wage";
                            wve."Entry Type" := 3;
                            wve."Cost Amount (Actual)" := ("Average Wage" * WageSetup."Invaalid Fund %" / 100) * ((Employees DIV WageSetup."No. Of Employees") - "Disabled Employees");
                            wve."Cost Posted to G/L" := ("Average Wage" * WageSetup."Invaalid Fund %" / 100) * ((Employees DIV WageSetup."No. Of Employees") - "Disabled Employees");
                            wve.INSERT;
                        END
                        ELSE BEGIN
                            //wve.SETFILTER("Contribution Type",'%1',WageSetup."Invalid Fund Contribution Code");
                            wve.SETFILTER("Employee No.", '%1', '');
                            IF wve.FIND('-') THEN BEGIN
                                wve."Cost Amount (Actual)" := ("Average Wage" * WageSetup."Invaalid Fund %" / 100) * ((Employees DIV WageSetup."No. Of Employees") - "Disabled Employees");
                                wve."Cost Posted to G/L" := ("Average Wage" * WageSetup."Invaalid Fund %" / 100) * ((Employees DIV WageSetup."No. Of Employees") - "Disabled Employees");
                                wve.MODIFY;
                            END;
                        END;

                        // UNTIL emp.NEXT=0 ;
                    end;
                }
                field("Payment Date"; "Payment Date")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        WC.SETFILTER("Wage Header No.", '%1', "No.");
                        WC.SETFILTER("Wage Calculation Type", '%1', 0);
                        IF WC.FIND('-') THEN
                            REPEAT
                                WC."Payment Date" := "Payment Date";
                                WC.MODIFY;
                            UNTIL WC.NEXT = 0;
                    end;
                }
                field("Closing Date"; "Closing Date")
                {
                    ApplicationArea = all;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = all;
                }
                field(Timestamp_WH; Timestamp_WH)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Payment Orders printed"; "Payment Orders printed")
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field(Employees; Employees)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Brutto Sum"; "Brutto Sum")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        WageSetup.GET;
                        "Average Wage - Chamber(triple)" := ((WageSetup."Chamber Rate(%)" / 100) * "Brutto Sum") * WageSetup."Brutto Rate";
                        "Average Wage - Chamber" := "Average Wage - Chamber(triple)" / 3;

                        IF "Average Wage - Chamber(triple)" <= "Chamber Amount" THEN
                            "For payment - Chamber" := "Average Wage - Chamber"
                        ELSE
                            "For payment - Chamber" := "Average Wage - Chamber";
                        "Chamber Amount" := "Average Wage - Chamber";

                        //emp.SETFILTER("Contribution Category Code",'%1','FBiH' );
                        //emp.SETFILTER("For Calculation",'%1',TRUE );
                        //IF emp.FIND('-')THEN REPEAT

                        IF cpe1.FINDLAST THEN No := INCSTR(cpe."Wage Calc No.");
                        cpe.SETRANGE("Wage Header No.", xRec."No.");
                        cpe.SETRANGE("Wage Calculation Type", 0);
                        IF cpe.FIND('+')
                        THEN BEGIN
                            cpe1.SETFILTER("Wage Header No.", '%1', xRec."No.");
                            cpe1.SETFILTER("Wage Calc No.", '%1', "No.");
                            cpe1.SETFILTER("Contribution Code", '%1', WageSetup."Chamber Fee Contribution Code");
                            IF NOT cpe1.FINDFIRST THEN BEGIN
                                cpe1.INIT;
                                cpe1."Wage Header No." := xRec."No.";
                                cpe1."Wage Calc No." := No;
                                cpe1."Employee No." := '';
                                cpe1."Contribution Code" := WageSetup."Chamber Fee Contribution Code";
                                cpe1."Amount Over Wage" := "For payment - Chamber";
                                cpe1."Amount Over Neto" := "For payment - Chamber";
                                IF "Average Wage - Chamber(triple)" <= "Chamber Amount" THEN
                                    cpe1.Basis := Rec."Average Wage - Chamber"
                                ELSE
                                    cpe1.Basis := "Chamber Amount";
                                WageSetup.GET;
                                cpe1."Global Dimension 1 Code" := WageSetup."Global Dimension 1 Code Chambe";
                                cpe1.INSERT;
                            END
                            ELSE BEGIN
                                cpe1.SETFILTER("Employee No.", '%1', '');
                                IF cpe1.FIND('-') THEN BEGIN
                                    cpe1."Amount Over Wage" := "For payment - Chamber";
                                    IF "Average Wage - Chamber(triple)" <= "Chamber Amount" THEN
                                        cpe1.Basis := Rec."Average Wage - Chamber"
                                    ELSE
                                        cpe1.Basis := "Chamber Amount";
                                    cpe1.MODIFY;
                                END;
                            END;
                        END;

                        wve2.SETFILTER("Document No.", '%1', xRec."No.");
                        wve2.SETFILTER("Contribution Type", '%1', WageSetup."Chamber Fee Contribution Code");
                        IF NOT wve2.FINDFIRST THEN BEGIN
                            IF wve.FINDLAST THEN ValueEntryNo := wve."Entry No." + 1;
                            wve.INIT;
                            wve."Entry No." := ValueEntryNo;
                            wve."Employee No." := '';
                            wve."Document No." := xRec."No.";
                            wve.Description := 'Doprinos za privrednu komoru';
                            wve."Wage Posting Group" := 'FBiH';
                            wve."Wage Ledger Entry No." := WLE."Entry No.";
                            wve."User ID" := USERID;
                            wve."Global Dimension 1 Code" := WageSetup."Global Dimension 1 Code Chambe";
                            //WVE."Global Dimension 2 Code":=WLE."Global Dimension 2 Code";
                            //WVE."Shortcut Dimension 4 Code":=WLE."Shortcut Dimension 4 Code";
                            wve."Document Date" := TODAY;
                            wve."Posting Date" := af.GetMonthRange(xRec."Month Of Wage", xRec."Year Of Wage", FALSE);
                            ;
                            wve."Contribution Type" := WageSetup."Chamber Fee Contribution Code";
                            wve."Post Code" := emp."Post Code";
                            IF "Average Wage - Chamber(triple)" <= "Chamber Amount" THEN
                                wve.Basis := Rec."Average Wage - Chamber"
                            ELSE
                                wve.Basis := "Chamber Amount";
                            wve."Entry Type" := 3;
                            wve."Cost Amount (Actual)" := "For payment - Chamber";
                            wve."Cost Posted to G/L" := "For payment - Chamber";
                            wve.INSERT;
                        END
                        ELSE BEGIN
                            //wve.SETFILTER("Contribution Type",'%1',WageSetup."Invalid Fund Contribution Code");
                            wve.SETFILTER("Employee No.", '%1', '');
                            IF wve.FIND('-') THEN BEGIN
                                wve."Cost Amount (Actual)" := "For payment - Chamber";
                                wve."Cost Posted to G/L" := "For payment - Chamber";
                                IF "Average Wage - Chamber(triple)" <= "Chamber Amount" THEN
                                    wve.Basis := Rec."Average Wage - Chamber"
                                ELSE
                                    wve.Basis := "Chamber Amount";
                                wve.MODIFY;
                            END;
                        END;

                        // UNTIL emp.NEXT=0 ;
                    end;
                }
            }
            group(Parameters)
            {
                Caption = 'Parameters';
                field("Hour Pool"; "Hour Pool")
                {
                    ApplicationArea = all;
                }
                field(Transportation; Transportation)
                {
                    ApplicationArea = all;
                }
                field(Reduction; Reduction)
                {
                    ApplicationArea = all;
                }
            }
            group(Chamber)
            {
                Caption = 'Chamber';
                field("Average Wage - Chamber"; "Average Wage - Chamber")
                {
                    ApplicationArea = all;
                }
                field("Average Wage - Chamber(triple)"; "Average Wage - Chamber(triple)")
                {
                    ApplicationArea = all;
                    Caption = 'Average Wage - Chamber(triple)';
                }
                field("Chamber Amount"; "Chamber Amount")
                {
                    ApplicationArea = all;
                }
            }
            group(Totals)
            {
                Caption = 'Totals';
                field(Brutto; Brutto)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Net Wage"; "Net Wage")
                {
                    ApplicationArea = all;
                }
                field("Add. Tax From Brutto"; "Add. Tax From Brutto")
                {
                    ApplicationArea = all;
                }
                field("Add. Tax Over Brutto"; "Add. Tax Over Brutto")
                {
                    ApplicationArea = all;
                }
                field("Wage Reduction"; "Wage Reduction")
                {
                    ApplicationArea = all;
                }
                field(Transport; Transport)
                {
                    ApplicationArea = all;
                }

                field("Sick Leave-Company"; "Sick Leave-Company")
                {
                    ApplicationArea = all;
                }
                field("Sick Leave-Fund"; "Sick Leave-Fund")
                {
                    ApplicationArea = all;
                }
                field("Untaxable Wage"; "Untaxable Wage")
                {
                    ApplicationArea = all;
                }
                field("Tax Basis"; "Tax Basis")
                {
                    ApplicationArea = all;
                }
                field(Tax; Tax)
                {
                    ApplicationArea = all;
                }
                field(Payment; Payment)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
            group(Additions)
            {
                Caption = 'Additions';
                field("Addition Sum"; "Addition Sum")
                {
                    ApplicationArea = all;
                }
                field("Addition Netto"; "Addition Netto")
                {
                    ApplicationArea = all;
                }
                field("Addition Brutto"; "Addition Brutto")
                {
                    ApplicationArea = all;
                }
                field("Addition Tax"; "Addition Tax")
                {
                    ApplicationArea = all;
                }
                field("Addition Contr. From"; "Addition Contr. From")
                {
                    ApplicationArea = all;
                }
                field("Addition Contr. To"; "Addition Contr. To")
                {
                    ApplicationArea = all;
                }
            }
            group("Totals TS")
            {
                Caption = 'Totals for Temporary services';
                field("Brutto TS"; "Brutto TS")
                {
                    ApplicationArea = all;
                }
                field("Net Wage TS"; "Net Wage TS")
                {
                    ApplicationArea = all;
                }
                field("Add. Tax From Brutto TS"; "Add. Tax From Brutto TS")
                {
                    ApplicationArea = all;
                }
                field("Add. Tax Over Brutto TS"; "Add. Tax Over Brutto TS")
                {
                    ApplicationArea = all;
                }
                field("Tax Basis TS"; "Tax Basis TS")
                {
                    ApplicationArea = all;
                }
                field("Tax TS"; "Tax TS")
                {
                    ApplicationArea = all;
                }
                field("Payment Date (TS Residents)"; "Payment Date (TS Residents)")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        WC.SETFILTER("Wage Header No.", '%1', "No.");
                        IF WC.FIND('-') THEN
                            REPEAT
                                WC."Payment Date (TS Residents)" := "Payment Date (TS Residents)";
                                WC.MODIFY;
                            UNTIL WC.NEXT = 0;
                    end;
                }
            }
            group("Totals TS NR")
            {
                Caption = 'Totals for Temporary services Non Residents';
                field("Brutto TS NR"; "Brutto TS NR")
                {
                    ApplicationArea = all;
                }
                field("Net Wage TS NR"; "Net Wage TS NR")
                {
                    ApplicationArea = all;
                }
                field("Add. Tax From Brutto TS NR"; "Add. Tax From Brutto TS NR")
                {
                    ApplicationArea = all;
                }
                field("Add. Tax Over Brutto TS NR"; "Add. Tax Over Brutto TS NR")
                {
                    ApplicationArea = all;
                }
                field("Tax Basis TS NR"; "Tax Basis TS NR")
                {
                    ApplicationArea = all;
                }
                field("Tax TS NR"; "Tax TS NR")
                {
                    ApplicationArea = all;
                }
                field("Payment Date (TS No Residents)"; "Payment Date (TS No Residents)")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        WC.SETFILTER("Wage Header No.", '%1', "No.");
                        IF WC.FIND('-') THEN
                            REPEAT
                                WC."Payment Date (TS No Residents)" := "Payment Date (TS No Residents)";
                                WC.MODIFY;
                            UNTIL WC.NEXT = 0;
                    end;
                }
            }
            group("Totals TS AC")
            {
                Caption = 'Totals for Author Contracts';
                field("Brutto TS AC"; "Brutto TS AC")
                {
                    ApplicationArea = all;
                }
                field("Net Wage TS AC"; "Net Wage TS AC")
                {
                    ApplicationArea = all;
                }
                field("Add. Tax From Brutto TS AC"; "Add. Tax From Brutto TS AC")
                {
                    ApplicationArea = all;
                }
                field("Add. Tax Over Brutto TS AC"; "Add. Tax Over Brutto TS AC")
                {
                    ApplicationArea = all;
                }
                field("Tax Basis TS AC"; "Tax Basis TS AC")
                {
                    ApplicationArea = all;
                }
                field("Tax TS AC"; "Tax TS AC")
                {
                    ApplicationArea = all;
                }
                field("Payment Date (Author Contract)"; "Payment Date (Author Contract)")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        WC.SETFILTER("Wage Header No.", '%1', "No.");
                        IF WC.FIND('-') THEN
                            REPEAT
                                WC."Payment Date (Author Contract)" := "Payment Date (Author Contract)";
                                WC.MODIFY;
                            UNTIL WC.NEXT = 0;
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Payment Orders1")
            {
                Caption = 'Payment Orders';
                Image = Payables;
                action("Priprema UPP naloga")
                {
                    //  Caption = 'Payment Order preparation';
                    Image = Payment;
                    Promoted = false;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        WithConfirm: Boolean;
                    begin
                        IF Rec."Negative Payment" = 0 THEN BEGIN
                            Municipality.SETFILTER(Code, '<>%1', '');
                            IF Municipality.FIND('-') THEN
                                REPEAT
                                    Municipality."For Calculation" := 0;
                                    Municipality."For Calculation 2" := 0;
                                    Municipality.MODIFY;
                                UNTIL Municipality.NEXT = 0;
                            //WithConfirm := CONFIRM(Txt005,FALSE);
                            CloseWageCalc.POrdersInitValue(Rec, WithConfirm);
                        END
                        ELSE BEGIN
                            ERROR(Txt013);
                        END;
                    end;
                }
                action("Priprema UPP naloga - odvojeni obračun dodataka")
                {
                    Caption = 'Priprema UPP naloga - odvojeni obračun dodataka';
                    Image = Payment;
                    Promoted = false;
                    ApplicationArea = all;


                    trigger OnAction()
                    var
                        WithConfirm: Boolean;
                    begin
                        CloseWageCalc.POrdersAdditionsInitValue(Rec, WithConfirm);


                        /*Municipality.SETFILTER(Code,'<>%1','');
                         IF Municipality.FIND('-') THEN REPEAT
                         Municipality."For Calculation":=0;
                         Municipality."For Calculation 2":=0;
                         Municipality."For Calculation 3":=0;
                         Municipality."For Calculation 4":=0;
                         Municipality."For Calculation FA 3":=0;
                         Municipality."For Calculation 5":=0;
                         Municipality."For Calculation 6":=0;
                         Municipality."For Calculation 7":=0;
                         Municipality."For Calculation FA":=0;
                         Municipality."For Calculation 8":=0;
                         Municipality."For Calculation 9":=0;
                         Municipality."For Calculation 10":=0;
                         Municipality."For Calculation 11":=0;
                         Municipality."For Calculation 12":=0;
                         Municipality."For Calculation 13":=0;

                         Municipality.MODIFY;
                         UNTIL Municipality.NEXT=0;
                         Orgdijelovi.RESET;

                        IF Orgdijelovi.FINDFIRST THEN REPEAT
                       Orgdijelovi."For Calculation":=0;
                       Orgdijelovi."For Calculation 2":=0;
                       Orgdijelovi."For Calculation 3":=0;
                       Orgdijelovi."For Calculation 4":=0;
                       Orgdijelovi."For Calculation 5":=0;
                       Orgdijelovi."For Calculation 6":=0;
                       Orgdijelovi."For Calculation 7":=0;
                       Orgdijelovi."For Calculation FA":=0;
                       Orgdijelovi."For Calculation FA 2":=0;
                       Orgdijelovi."For Calculation FA 3":=0;
                       Orgdijelovi."For Calculation 8":=0;
                       Orgdijelovi."For Calculation 9":=0;
                       Orgdijelovi."For Calculation 10":=0;
                       Orgdijelovi."For Calculation 11":=0;
                       Orgdijelovi."For Calculation 12":=0;
                       Orgdijelovi."For Calculation 13":=0;
                       Orgdijelovi."For Calculation 14":=0;
                       Orgdijelovi."For Calculation 15":=0;
                       Orgdijelovi.MODIFY;
                        UNTIL Orgdijelovi.NEXT=0;

                       //WithConfirm := CONFIRM(Txt005,FALSE);

                       CloseWageCalc.DoprinosiDodaci(Rec);

                         Municipality.SETFILTER(Code,'<>%1','');
                         IF Municipality.FIND('-') THEN REPEAT
                         Municipality."For Calculation":=0;
                         Municipality."For Calculation 2":=0;
                         Municipality."For Calculation 3":=0;
                         Municipality."For Calculation 4":=0;
                         Municipality."For Calculation FA 3":=0;
                         Municipality."For Calculation 5":=0;
                         Municipality."For Calculation 6":=0;
                         Municipality."For Calculation 7":=0;
                         Municipality."For Calculation FA":=0;
                         Municipality."For Calculation 8":=0;
                         Municipality."For Calculation 9":=0;
                         Municipality."For Calculation 10":=0;
                         Municipality."For Calculation 11":=0;
                         Municipality."For Calculation 12":=0;
                         Municipality."For Calculation 13":=0;
                         Municipality.MODIFY;
                         UNTIL Municipality.NEXT=0;

                       Orgdijelovi.RESET;
                        IF Orgdijelovi.FINDFIRST THEN REPEAT
                       Orgdijelovi."For Calculation":=0;
                       Orgdijelovi."For Calculation 2":=0;
                       Orgdijelovi."For Calculation 3":=0;
                       Orgdijelovi."For Calculation 4":=0;
                       Orgdijelovi."For Calculation 5":=0;
                       Orgdijelovi."For Calculation 6":=0;
                       Orgdijelovi."For Calculation 7":=0;
                       Orgdijelovi."For Calculation FA":=0;
                       Orgdijelovi."For Calculation FA 2":=0;
                       Orgdijelovi."For Calculation FA 3":=0;
                       Orgdijelovi."For Calculation 8":=0;
                       Orgdijelovi."For Calculation 9":=0;
                       Orgdijelovi."For Calculation 10":=0;
                       Orgdijelovi."For Calculation 11":=0;
                       Orgdijelovi."For Calculation 12":=0;
                       Orgdijelovi."For Calculation 13":=0;
                       Orgdijelovi."For Calculation 14":=0;
                       Orgdijelovi."For Calculation 15":=0;
                       Orgdijelovi.MODIFY;
                        UNTIL Orgdijelovi.NEXT=0;

                       CloseWageCalc.DoprinosiDodaciBD(Rec);
                         Municipality.SETFILTER(Code,'<>%1','');
                         IF Municipality.FIND('-') THEN REPEAT
                         Municipality."For Calculation":=0;
                         Municipality."For Calculation 2":=0;
                         Municipality."For Calculation 3":=0;
                         Municipality."For Calculation 4":=0;
                         Municipality."For Calculation FA 3":=0;
                         Municipality."For Calculation 5":=0;
                         Municipality."For Calculation 6":=0;
                         Municipality."For Calculation 7":=0;
                         Municipality."For Calculation FA":=0;
                         Municipality."For Calculation 8":=0;
                         Municipality."For Calculation 9":=0;
                         Municipality."For Calculation 10":=0;
                         Municipality."For Calculation 11":=0;
                         Municipality."For Calculation 12":=0;
                         Municipality."For Calculation 13":=0;
                         Municipality.MODIFY;
                         UNTIL Municipality.NEXT=0;
                         Orgdijelovi.RESET;

                        IF Orgdijelovi.FINDFIRST THEN REPEAT
                       Orgdijelovi."For Calculation":=0;
                       Orgdijelovi."For Calculation 2":=0;
                       Orgdijelovi."For Calculation 3":=0;
                       Orgdijelovi."For Calculation 4":=0;
                       Orgdijelovi."For Calculation 5":=0;
                       Orgdijelovi."For Calculation 6":=0;
                       Orgdijelovi."For Calculation 7":=0;
                       Orgdijelovi."For Calculation FA":=0;
                       Orgdijelovi."For Calculation FA 2":=0;
                       Orgdijelovi."For Calculation FA 3":=0;
                       Orgdijelovi."For Calculation 8":=0;
                       Orgdijelovi."For Calculation 9":=0;
                       Orgdijelovi."For Calculation 10":=0;
                       Orgdijelovi."For Calculation 11":=0;
                       Orgdijelovi."For Calculation 12":=0;
                       Orgdijelovi."For Calculation 13":=0;
                       Orgdijelovi."For Calculation 14":=0;
                       Orgdijelovi."For Calculation 15":=0;
                       Orgdijelovi.MODIFY;
                        UNTIL Orgdijelovi.NEXT=0;

                       CloseWageCalc.DoprinosiDodaciBDRS(Rec);
                         Municipality.SETFILTER(Code,'<>%1','');
                         IF Municipality.FIND('-') THEN REPEAT
                         Municipality."For Calculation":=0;
                         Municipality."For Calculation 2":=0;
                         Municipality."For Calculation 3":=0;
                         Municipality."For Calculation 4":=0;
                         Municipality."For Calculation FA 3":=0;
                         Municipality."For Calculation 5":=0;
                         Municipality."For Calculation 6":=0;
                         Municipality."For Calculation 7":=0;
                         Municipality."For Calculation FA":=0;
                         Municipality."For Calculation 8":=0;
                         Municipality."For Calculation 9":=0;
                         Municipality."For Calculation 10":=0;
                         Municipality."For Calculation 11":=0;
                         Municipality."For Calculation 12":=0;
                         Municipality."For Calculation 13":=0;
                         Municipality.MODIFY;
                         UNTIL Municipality.NEXT=0;
                       Orgdijelovi.RESET;

                        IF Orgdijelovi.FINDFIRST THEN REPEAT
                       Orgdijelovi."For Calculation":=0;
                       Orgdijelovi."For Calculation 2":=0;
                       Orgdijelovi."For Calculation 3":=0;
                       Orgdijelovi."For Calculation 4":=0;
                       Orgdijelovi."For Calculation 5":=0;
                       Orgdijelovi."For Calculation 6":=0;
                       Orgdijelovi."For Calculation 7":=0;
                       Orgdijelovi."For Calculation FA":=0;
                       Orgdijelovi."For Calculation FA 2":=0;
                       Orgdijelovi."For Calculation FA 3":=0;
                       Orgdijelovi."For Calculation 8":=0;
                       Orgdijelovi."For Calculation 9":=0;
                       Orgdijelovi."For Calculation 10":=0;
                       Orgdijelovi."For Calculation 11":=0;
                       Orgdijelovi."For Calculation 12":=0;
                       Orgdijelovi."For Calculation 13":=0;
                       Orgdijelovi."For Calculation 14":=0;
                       Orgdijelovi."For Calculation 15":=0;
                       Orgdijelovi.MODIFY;
                        UNTIL Orgdijelovi.NEXT=0;

                       CloseWageCalc.DoprinosiRS(Rec);
                         Municipality.SETFILTER(Code,'<>%1','');
                         IF Municipality.FIND('-') THEN REPEAT
                         Municipality."For Calculation":=0;
                         Municipality."For Calculation 2":=0;
                          Municipality."For Calculation 3":=0;
                           Municipality."For Calculation 4":=0;
                         Municipality."For Calculation FA 3":=0;
                         Municipality."For Calculation 5":=0;
                         Municipality."For Calculation 6":=0;
                         Municipality."For Calculation 7":=0;
                         Municipality."For Calculation FA":=0;
                         Municipality."For Calculation 8":=0;
                         Municipality."For Calculation 9":=0;
                         Municipality."For Calculation 10":=0;
                         Municipality."For Calculation 11":=0;
                         Municipality."For Calculation 12":=0;
                         Municipality."For Calculation 13":=0;
                         Municipality.MODIFY;
                         UNTIL Municipality.NEXT=0;
                         Orgdijelovi.RESET;

                        IF Orgdijelovi.FINDFIRST THEN REPEAT
                       Orgdijelovi."For Calculation":=0;
                       Orgdijelovi."For Calculation 2":=0;
                       Orgdijelovi."For Calculation 3":=0;
                       Orgdijelovi."For Calculation 4":=0;
                       Orgdijelovi."For Calculation 5":=0;
                       Orgdijelovi."For Calculation 6":=0;
                       Orgdijelovi."For Calculation 7":=0;
                       Orgdijelovi."For Calculation FA":=0;
                       Orgdijelovi."For Calculation FA 2":=0;
                       Orgdijelovi."For Calculation FA 3":=0;
                       Orgdijelovi."For Calculation 8":=0;
                       Orgdijelovi."For Calculation 9":=0;
                       Orgdijelovi."For Calculation 10":=0;
                       Orgdijelovi."For Calculation 11":=0;
                       Orgdijelovi."For Calculation 12":=0;
                       Orgdijelovi."For Calculation 13":=0;
                       Orgdijelovi."For Calculation 14":=0;
                       Orgdijelovi."For Calculation 15":=0;
                       Orgdijelovi.MODIFY;
                        UNTIL Orgdijelovi.NEXT=0;

                       CloseWageCalc.DoprinosiRSFBIH(Rec);
                         Municipality.SETFILTER(Code,'<>%1','');
                         IF Municipality.FIND('-') THEN REPEAT
                         Municipality."For Calculation":=0;
                         Municipality."For Calculation 2":=0;
                         Municipality."For Calculation 3":=0;
                         Municipality."For Calculation 4":=0;
                         Municipality."For Calculation FA 3":=0;
                         Municipality."For Calculation 5":=0;
                         Municipality."For Calculation 6":=0;
                         Municipality."For Calculation 7":=0;
                         Municipality."For Calculation FA":=0;
                         Municipality."For Calculation 8":=0;
                         Municipality."For Calculation 9":=0;
                         Municipality."For Calculation 10":=0;
                         Municipality."For Calculation 11":=0;
                         Municipality."For Calculation 12":=0;
                         Municipality."For Calculation 13":=0;
                         Municipality.MODIFY;
                         UNTIL Municipality.NEXT=0;
                       Orgdijelovi.RESET;

                        IF Orgdijelovi.FINDFIRST THEN REPEAT
                       Orgdijelovi."For Calculation":=0;
                       Orgdijelovi."For Calculation 2":=0;
                       Orgdijelovi."For Calculation 3":=0;
                       Orgdijelovi."For Calculation 4":=0;
                       Orgdijelovi."For Calculation 5":=0;
                       Orgdijelovi."For Calculation 6":=0;
                       Orgdijelovi."For Calculation 7":=0;
                       Orgdijelovi."For Calculation FA":=0;
                       Orgdijelovi."For Calculation FA 2":=0;
                       Orgdijelovi."For Calculation FA 3":=0;
                       Orgdijelovi."For Calculation 8":=0;
                       Orgdijelovi."For Calculation 9":=0;
                       Orgdijelovi."For Calculation 10":=0;
                       Orgdijelovi."For Calculation 11":=0;
                       Orgdijelovi."For Calculation 12":=0;
                       Orgdijelovi."For Calculation 13":=0;
                       Orgdijelovi."For Calculation 14":=0;
                       Orgdijelovi."For Calculation 15":=0;
                       Orgdijelovi.MODIFY;
                        UNTIL Orgdijelovi.NEXT=0;

                       CloseWageCalc.PoreziDodaciBDRS(Rec);
                         Municipality.SETFILTER(Code,'<>%1','');
                         IF Municipality.FIND('-') THEN REPEAT
                         Municipality."For Calculation":=0;
                         Municipality."For Calculation 2":=0;
                         Municipality."For Calculation 3":=0;
                         Municipality."For Calculation 4":=0;
                         Municipality."For Calculation FA 3":=0;
                         Municipality."For Calculation 5":=0;
                         Municipality."For Calculation 6":=0;
                         Municipality."For Calculation 7":=0;
                         Municipality."For Calculation FA":=0;
                         Municipality."For Calculation 8":=0;
                         Municipality."For Calculation 9":=0;
                         Municipality."For Calculation 10":=0;
                         Municipality."For Calculation 11":=0;
                         Municipality."For Calculation 12":=0;
                         Municipality."For Calculation 13":=0;
                         Municipality.MODIFY;
                         UNTIL Municipality.NEXT=0;

                       Orgdijelovi.RESET;

                        IF Orgdijelovi.FINDFIRST THEN REPEAT
                       Orgdijelovi."For Calculation":=0;
                       Orgdijelovi."For Calculation 2":=0;
                       Orgdijelovi."For Calculation 3":=0;
                       Orgdijelovi."For Calculation 4":=0;
                       Orgdijelovi."For Calculation 5":=0;
                       Orgdijelovi."For Calculation 6":=0;
                       Orgdijelovi."For Calculation 7":=0;
                       Orgdijelovi."For Calculation FA":=0;
                       Orgdijelovi."For Calculation FA 2":=0;
                       Orgdijelovi."For Calculation FA 3":=0;
                       Orgdijelovi."For Calculation 8":=0;
                       Orgdijelovi."For Calculation 9":=0;
                       Orgdijelovi."For Calculation 10":=0;
                       Orgdijelovi."For Calculation 11":=0;
                       Orgdijelovi."For Calculation 12":=0;
                       Orgdijelovi."For Calculation 13":=0;
                       Orgdijelovi."For Calculation 14":=0;
                       Orgdijelovi."For Calculation 15":=0;
                       Orgdijelovi.MODIFY;
                        UNTIL Orgdijelovi.NEXT=0;

                       CloseWageCalc.DodaciPoBankama(Rec);
                       CloseWageCalc.PoreziDodaci(Rec);
                         Municipality.SETFILTER(Code,'<>%1','');
                         IF Municipality.FIND('-') THEN REPEAT
                         Municipality."For Calculation":=0;
                         Municipality."For Calculation 2":=0;
                         Municipality."For Calculation 3":=0;
                         Municipality."For Calculation 4":=0;
                         Municipality."For Calculation FA 3":=0;
                         Municipality."For Calculation 5":=0;
                         Municipality."For Calculation 6":=0;
                         Municipality."For Calculation 7":=0;
                         Municipality."For Calculation FA":=0;
                         Municipality."For Calculation 8":=0;
                         Municipality."For Calculation 9":=0;
                         Municipality."For Calculation 10":=0;
                         Municipality."For Calculation 11":=0;
                         Municipality."For Calculation 12":=0;
                         Municipality."For Calculation 13":=0;
                         Municipality.MODIFY;
                         UNTIL Municipality.NEXT=0;

                       Orgdijelovi.RESET;

                        IF Orgdijelovi.FINDFIRST THEN REPEAT
                       Orgdijelovi."For Calculation":=0;
                       Orgdijelovi."For Calculation 2":=0;
                       Orgdijelovi."For Calculation 3":=0;
                       Orgdijelovi."For Calculation 4":=0;
                       Orgdijelovi."For Calculation 5":=0;
                       Orgdijelovi."For Calculation 6":=0;
                       Orgdijelovi."For Calculation 7":=0;
                       Orgdijelovi."For Calculation FA":=0;
                       Orgdijelovi."For Calculation FA 2":=0;
                       Orgdijelovi."For Calculation FA 3":=0;
                       Orgdijelovi."For Calculation 8":=0;
                       Orgdijelovi."For Calculation 9":=0;
                       Orgdijelovi."For Calculation 10":=0;
                       Orgdijelovi."For Calculation 11":=0;
                       Orgdijelovi."For Calculation 12":=0;
                       Orgdijelovi."For Calculation 13":=0;
                       Orgdijelovi."For Calculation 14":=0;
                       Orgdijelovi."For Calculation 15":=0;
                       Orgdijelovi.MODIFY;
                        UNTIL Orgdijelovi.NEXT=0;
                       CloseWageCalc.PoreziDodaciRS(Rec);
                       CloseWageCalc.PoreziDodaciBD(Rec);*/


                    end;
                }
                action("Pregled UPP naloga")
                {
                    Caption = 'Payment Orders';
                    Image = Check;
                    RunObject = Page "Payment Orders";
                    ApplicationArea = all;
                }

                action("Priprema  UPP naloga - privremeni i povremeni ugovori")
                {
                    Caption = ' i povremeni ugovori';
                    Image = Payment;
                    Promoted = false;
                    ApplicationArea = all;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    var
                        WithConfirm: Boolean;
                    begin
                        CompanyInfo.get();
                        Municipality.SETFILTER(Code, '<>%1', '');
                        IF Municipality.FIND('-') THEN
                            REPEAT
                                Municipality."For Calculation" := 0;
                                Municipality."For Calculation 2" := 0;
                                Municipality."For Calculation 3" := 0;
                                Municipality.MODIFY;
                            UNTIL Municipality.NEXT = 0;

                        WithConfirm := CONFIRM(Txt005, FALSE);


                        Municipality.SETFILTER(Code, '<>%1', '');
                        IF Municipality.FIND('-') THEN
                            REPEAT
                                Municipality."For Calculation" := 0;
                                Municipality."For Calculation 2" := 0;
                                Municipality.MODIFY;
                            UNTIL Municipality.NEXT = 0;


                        Municipality.SETFILTER(Code, '<>%1', '');
                        IF Municipality.FIND('-') THEN
                            REPEAT
                                Municipality."For Calculation" := 0;
                                Municipality."For Calculation 2" := 0;
                                Municipality."For Calculation 3" := 0;
                                Municipality.MODIFY;
                            UNTIL Municipality.NEXT = 0;


                        if CompanyInfo."Entity Code" <> 'RS' then begin
                            CloseWageCalc.UOD(Rec);
                            CloseWageCalc.DoprinosiTCAC(Rec);
                            CloseWageCalc.DoprinosiTC(Rec);
                            CloseWageCalc.DoprinosiTCNR(Rec);
                            CloseWageCalc.PoreziTC(Rec);
                            CloseWageCalc.PoreziTCNR(Rec);
                            CloseWageCalc.PoreziTCAC(Rec);
                        end
                        else begin


                            CloseWageCalc.UOD(Rec);
                            CloseWageCalc.DoprinosiTCACRS(Rec);
                            CloseWageCalc.DoprinosiTCRS(Rec);
                            CloseWageCalc.DoprinosiTCNR(Rec);
                            CloseWageCalc.PoreziTC(Rec);
                            CloseWageCalc.PoreziTCNR(Rec);
                            CloseWageCalc.PoreziTCAC(Rec);

                        end;
                        AddTaxPE.SETFILTER(Calculated, '%1', FALSE);
                        AddTaxPE.SETFILTER("Wage Calculation Type", '%1|%2|%3', 1, 2, 3);
                        IF AddTaxPE.FIND('-') THEN
                            REPEAT
                                AddTaxPE.Calculated := TRUE;
                                AddTaxPE.MODIFY;
                            UNTIL AddTaxPE.NEXT = 0;
                    end;
                }
                /*ĐK  action("Priprema virmana za eksterno bankatstvo")
                  {
                      //Hypo export
                      Caption = 'Priprema virmana za eksterno bankatstvo';
                      Image = Check;
                      RunObject = Report "Hypo export";
                      ApplicationArea = all;

                  }*/

            }




            action("Kreiraj nalog za knjiženje")

            {
                Caption = 'Tranfer calculation to Gen. Journal';
                Image = Post;
                Promoted = false;
                ApplicationArea = all;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = false;

                trigger OnAction()
                begin
                    IF Rec."Negative Payment" = 0 THEN BEGIN
                        IF CONFIRM(Txt003, FALSE, Rec.Description) THEN BEGIN
                            WLE.SETRANGE("Document No.", xRec."No.");
                            WLE.SETRANGE("Wage Header Entry No.", xRec."Entry No.");
                            Commit();
                            REPORT.RUNMODAL(REPORT::"Post Wage to GL", TRUE, TRUE, WLE);
                            Commit();
                        END;
                    END
                    ELSE BEGIN
                        ERROR(Txt013);
                    END;
                end;

            }

            group("Create files1")
            {
                Caption = 'Create files';
                Image = Transactions;
                Visible = true;
                /*       action("Wage Posting")
                       {
                           Caption = 'Wage Posting';
                           Image = WageLines;
                           ApplicationArea = all;
                           trigger OnAction()
                           var
                               R_TS1: Report "TS_knjizenja 1";
                               WH: Record "Wage Header";
                               Calc: Record "Wage Calculation";
                               FileManagement: Codeunit "File Management";
                               filename: Text;
                           begin
                               IF Rec."Negative Payment" = 0 THEN BEGIN
                                   WH.RESET;
                                   WH.SETRANGE("Month Of Wage", Rec."Month Of Wage");
                                   WH.SETRANGE("Year Of Wage", Rec."Year Of Wage");

                                   IF NOT WH.FIND('-') THEN
                                       ERROR('Ne postoji obračun plata!')
                                   ELSE BEGIN


                                       CLEAR(R_TS1);
                                       CLEAR(FileManagement);
                                       WS.GET;
                                       PO.RESET;
                                       WH.CALCFIELDS("Payment UPP");
                                       filename := WS."Export Report Path" + FORMAT(WH."Payment UPP") + '~02~LD RBBH~' + FORMAT(WH."Date Of Calculation") + '.xls';
                                       R_TS1.SetParam(Rec."No.");
                                       PO.SetRange("Wage Header No.", Rec."No.");
                                       R_TS1.SAVEASEXCEL(filename);
                                       FileManagement.DownloadToFile(filename, filename);
                                       //FileManagement.DownloadToFile(filename, filename);


                                   END;
                               END
                               ELSE BEGIN
                                   ERROR(Txt013);
                               END;
                           end;
                       }*/
                /*   action("Wage Posting Additions")
                   {
                       Caption = 'Wage Posting';
                       Image = WageLines;
                       ApplicationArea = all;
                       trigger OnAction()
                       var
                           //ĐK      R_TS1: Report "TS_knjizenja 1";
                           WH: Record "Wage Header";
                           Calc: Record "Wage Calculation";
                           FileManagement: Codeunit "File Management";
                           filename: Text;
                       begin
                           IF Rec."Negative Payment" = 0 THEN BEGIN
                               WH.RESET;
                               WH.SETRANGE("Month Of Wage", Rec."Month Of Wage");
                               WH.SETRANGE("Year Of Wage", Rec."Year Of Wage");

                               IF NOT WH.FIND('-') THEN
                                   ERROR('Ne postoji obračun plata!')
                               ELSE BEGIN


                                   //ĐK     CLEAR(R_TSAdd);
                                   CLEAR(FileManagement);
                                   WS.GET;
                                   PO.RESET;
                                   WH.CALCFIELDS("Addition Netto");
                                   PaymentOrderNew.RESET;
                                   PaymentOrderNew.SETFILTER("Wage Calculation Type", '%1', PaymentOrderNew."Wage Calculation Type"::Additions);
                                   PaymentOrderNew.SETFILTER(Contributon, '%1', 'DODACI');
                                   PaymentOrderNew.SETFILTER("Wage Header No.", '%1', WH."No.");
                                   IF PaymentOrderNew.FINDFIRST THEN BEGIN
                                       PaymentOrderNew.CALCSUMS(Iznos);
                                       filename := WS."Export Report Path" + FORMAT(WH."Addition Netto") + '~02~LD RBBH~' + FORMAT(WH."Date Of Calculation") + '.xls';
                                       //R_TSAdd.SetParam(Rec."No.");
                                       // R_TSAdd.SAVEASEXCEL(filename);
                                       //     R_TSAdd.SetParam(Rec."No.");
                                       //ĐK   R_TSAdd.SAVEASEXCEL(filename);
                                       FileManagement.DownloadToFile(filename, filename);
                                       //  FileManagement.DownloadToFile(filename, filename);
                                   END;

                               END;
                           END
                           ELSE BEGIN
                               ERROR(Txt013);
                           END;
                       end;
                   }*/
                action("Reduction Posting")
                {
                    Caption = 'Reduction Posting';
                    Image = Reject;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        R_TS2: Report "TS_knjizenja 2";
                        WH: Record "Wage Header";
                        Calc: Record "Wage Calculation";
                        FileManagement: Codeunit "File Management";
                        filename: Text;
                        Newfilename: Text;

                    begin
                        IF Rec."Negative Payment" = 0 THEN BEGIN
                            WH.RESET;
                            WH.SETRANGE("Month Of Wage", Rec."Month Of Wage");
                            WH.SETRANGE("Year Of Wage", Rec."Year Of Wage");

                            IF NOT WH.FIND('-') THEN
                                ERROR('Ne postoji obračun plata!')
                            ELSE BEGIN


                                CLEAR(R_TS2);
                                CLEAR(FileManagement);
                                WS.GET;

                                PO.RESET;
                                //ĐK


                                filename := WS."Export Report Path" + FORMAT('PLACA I OSTALA PRIMANJA' + delchr(format(WH."Payment Date"), '.') + ' - +' + 'Naziv Banke') + '.xls';
                                /*       R_TS2.SetParam(Rec."No.");
                                       R_TS2.SAVEASEXCEL(filename);*/
                                FileManagement.DownloadToFile(filename, filename);
                                // PO.SetRange("Wage Header No.", Rec."No.");
                                //REPORT.SAVEASEXCEL(50099, filename, PO);

                            END;
                        END
                        ELSE BEGIN
                            ERROR(Txt013);
                        END;

                    end;
                }
                action("Contribution Posting")
                {
                    Caption = 'Contribution Posting';
                    Image = Relationship;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        //ĐK      R_TS3: Report "TS_knjizenja 3";
                        WH: Record "Wage Header";
                        Calc: Record "Wage Calculation";
                        FileManagement: Codeunit "File Management";
                        filename: Text;
                    begin
                        IF Rec."Negative Payment" = 0 THEN BEGIN
                            WH.RESET;
                            WH.SETRANGE("Month Of Wage", Rec."Month Of Wage");
                            WH.SETRANGE("Year Of Wage", Rec."Year Of Wage");

                            IF NOT WH.FIND('-') THEN
                                ERROR('Ne postoji obračun plata!')
                            ELSE BEGIN


                                //ĐK    CLEAR(R_TS3);
                                CLEAR(FileManagement);
                                WS.GET;
                                PO.RESET;
                                WH.CALCFIELDS("Contribution UPP");
                                filename := WS."Export Report Path" + FORMAT(WH."Contribution UPP") + '~01~DOPRINOSI LD~' + FORMAT(WH."Month Of Wage") + ' ' + FORMAT(WH."Year Of Wage") + '.xls';
                                /*R_TS3.SetParam(Rec."No.", 1);
                                R_TS3.SAVEASEXCEL(filename);*/
                                FileManagement.DownloadToFile(filename, filename);
                                //PO.SetRange("Wage Header No.", Rec."No.");
                                //PO.SETFILTER("Wage Calculation Type", '%1', PO."Wage Calculation Type"::Regular);
                                //REPORT.SAVEASEXCEL(50100, filename, PO);


                            END;
                        END
                        ELSE BEGIN
                            ERROR(Txt013);
                        END;
                    end;
                }
                action("Contribution Posting Add")
                {
                    Caption = 'Contribution Posting';
                    Image = Relationship;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        //ĐK     R_TS3: Report "TS_knjizenja 3";
                        WH: Record "Wage Header";
                        Calc: Record "Wage Calculation";
                        FileManagement: Codeunit "File Management";
                        filename: Text;
                    begin
                        IF Rec."Negative Payment" = 0 THEN BEGIN
                            WH.RESET;
                            WH.SETRANGE("Month Of Wage", Rec."Month Of Wage");
                            WH.SETRANGE("Year Of Wage", Rec."Year Of Wage");

                            IF NOT WH.FIND('-') THEN
                                ERROR('Ne postoji obračun plata!')
                            ELSE BEGIN


                                //                                CLEAR(R_TS3);
                                CLEAR(FileManagement);
                                WS.GET;
                                PO.RESET;
                                WH.CALCFIELDS("Contribution UPP Additions");
                                filename := WS."Export Report Path" + FORMAT(WH."Contribution UPP Additions") + '~01~DOPRINOSI LD~' + FORMAT(WH."Month Of Wage") + ' ' + FORMAT(WH."Year Of Wage") + '.xls';
                                /*     R_TS3.SetParam(Rec."No.", 2);
                                     R_TS3.SAVEASEXCEL(filename);*/
                                FileManagement.DownloadToFile(filename, filename);
                                //PO.SetRange("Wage Header No.", Rec."No.");
                                //PO.SETFILTER("Wage Calculation Type", '%1', PO."Wage Calculation Type"::Additions);
                                //REPORT.SAVEASEXCEL(50100, filename, PO);

                            END;
                        END
                        ELSE BEGIN
                            ERROR(Txt013);
                        END;
                    end;
                }

            }


            action("Zaključi obračun")
            {
                Image = Lock;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    IF Rec."Negative Payment" = 0 THEN BEGIN
                        BEGIN
                            CurrPage.SETSELECTIONFILTER(wh);
                            REPORT.RUNMODAL(REPORT::"Lock Calculation", FALSE, FALSE, wh);
                        END;
                    END
                    ELSE BEGIN
                        ERROR(Txt013);
                    END;
                end;
            }


            group(Delete1)
            {
                Caption = 'Delete';
                Image = Confirm;

                action("Otvori obračun")
                {
                    Caption = 'Open calculation';
                    Image = OpenWorksheet;
                    Promoted = false;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin

                        IF CONFIRM(Txt002, FALSE, Rec.Description) THEN BEGIN
                            CurrPage.SETSELECTIONFILTER(wh);
                            REPORT.RUN(REPORT::"Reopen Calculation", FALSE, FALSE, wh);
                        END;
                    end;
                }
                action("Obriši obračun")
                {
                    Caption = 'Delete wage calculation';
                    Image = Delete;
                    Promoted = false;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        GL: Record "G/L entry";
                        Wh: Record "Wage Header";
                        UserSet: Record "User Setup";
                    begin
                        IF Rec."Wage Calculation Type" = Rec."Wage Calculation Type"::Normal THEN BEGIN
                            IF CONFIRM(Txt002, FALSE, Rec.Description) THEN BEGIN
                                IF CONFIRM(Txt012, FALSE, Rec.Description) THEN BEGIN
                                    CurrPage.SETSELECTIONFILTER(wh);
                                    UserSet.reset;
                                    UserSet.setfilter("User ID", '%1', UserId);
                                    UserSet.SetFilter("Delete Wage", '%1', true);
                                    if not UserSet.FindFirst() then begin

                                        GL.Reset();
                                        GL.SetFilter("Document No.", '%1', 'PLATE ' + format(Rec."Payment Date"));
                                        if GL.FindFirst() then
                                            Error('Ne možete obrisati obračun koji je već proknjižen!');

                                        REPORT.RUN(REPORT::"Delete Calculation", FALSE, FALSE, wh);

                                    end
                                    else begin
                                        REPORT.RUN(REPORT::"Delete Calculation", FALSE, FALSE, wh);

                                    end;
                                END;
                            END;
                        END ELSE BEGIN
                            MESSAGE('Za brisanje dodataka, koristite opciju Obriši obračun dodataka');
                        END;
                    end;
                }
                action("Obriši obračun dodataka")
                {
                    Caption = 'Delete wage calculation';
                    Image = DeleteExpiredComponents;
                    Promoted = false;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        IF Rec."Wage Calculation Type" = Rec."Wage Calculation Type"::"Fixed Add" THEN BEGIN
                            IF CONFIRM(Txt002, FALSE, Rec.Description) THEN BEGIN
                                IF CONFIRM(Txt012, FALSE, Rec.Description) THEN BEGIN
                                    CurrPage.SETSELECTIONFILTER(wh);
                                    //ĐK   REPORT.RUN(REPORT::"Delete Additions", FALSE, FALSE, wh);
                                END;
                            END;
                        END ELSE BEGIN
                            MESSAGE('Za brisanje dodataka, koristite opciju Obriši redovni obračun');
                        END;
                    end;
                }

                action("Obriši obračun privremenih ugovora")
                {
                    Caption = 'Delete wage calculation';
                    Image = DeleteExpiredComponents;
                    Promoted = false;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        IF Rec."Wage Calculation Type" = Rec."Wage Calculation Type"::"Fixed Add" THEN BEGIN
                            IF CONFIRM(Txt002, FALSE, Rec.Description) THEN BEGIN
                                IF CONFIRM(Txt012, FALSE, Rec.Description) THEN BEGIN
                                    CurrPage.SETSELECTIONFILTER(wh);
                                    //ĐK       REPORT.RUN(REPORT::"Delete Additions", FALSE, FALSE, wh);
                                END;
                            END;
                        END ELSE BEGIN
                            MESSAGE('Za brisanje dodataka, koristite opciju Obriši redovni obračun');
                        END;
                    end;
                }



            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        //MODIFY;
        /*CurrPage.Brutto.UPDATE;
        CurrPage."Net Wage".UPDATE;
        CurrPage."Final Net Wage".UPDATE;
        CurrPage."Add. Tax From Brutto".UPDATE;
        CurrPage."Add. Tax Over Brutto".UPDATE;
        CurrPage.Tax.UPDATE;
        CurrPage."Tax Basis".UPDATE;
        //CurrPage."Added Tax Per City".UPDATE;
        CurrPage."Wage Reduction".UPDATE;
        CurrPage.Transport.UPDATE;
        CurrPage."Sick Leave-Company".UPDATE;
        CurrPage."Sick Leave-Fund".UPDATE;*/
        "Average Wage - Chamber(triple)" := 3 * "Average Wage - Chamber";

        IF "Average Wage - Chamber(triple)" <= "Chamber Amount" THEN
            "For payment - Chamber" := "Average Wage - Chamber(triple)"
        ELSE
            "For payment - Chamber" := "Chamber Amount";

    end;

    trigger OnInit()
    begin
        WS.GET();
    end;

    var
        Orgdijelovi: Record "ORG Dijelovi";
        TempFile: File;
        //  R_SetGLE: Report "Prenos nalog_knjiženja";
        Name: Text;
        Newstream: InStream;
        WageAm: Record "Wage Amounts";
        ToFile: Text;
        ReturnValue: Boolean;
        Department: Record "Department";
        EmpDefDim: Record "Employee Default Dimension";
        OrgD: Record "ORG Dijelovi";
        PaymentOrder: Record "Payment Order";
        WA: Record "Wage Addition";
        No: Code[10];
        PaymentOrderNew: Record "Payment Order";
        Correct: Decimal;
        wh: Record "Wage Header";
        WLE: Record "Wage Ledger Entry";
        WC: Record "Wage Calculation";
        Txt001: Label 'Do you want to close calculation %1?';
        Txt002: Label 'Do you want to delete calculatio %1? Note that deleting calculation does not reverse posting!';
        Txt003: Label 'Do you want to tranfer calculation %1 to Gen. Journal?';
        CloseWageCalc: Codeunit "Close Wage Calculation";
        // R_TSAdd: Report "TS_knjizenja dodaci";
        CCC: Record "Contribution Category Conn.";
        zaglavlje: Code[30];
        cpe: Record "Contribution Per Employee";
        prosjek: Decimal;
        dialbox: Dialog;
        Txt004: Label 'Enter average wage.';
        wve: Record "Wage Value Entry";
        Txt005: Label 'Do you want to review each payment order separately?';
        cpe1: Record "Contribution Per Employee";
        emp: Record "Employee";
        ValueEntryNo: Integer;
        af: Codeunit "Absence Fill";
        Municipality: Record "Municipality";
        Response: Boolean;
        //ĐK  Recapitulation: Record "Recapitulation";
        // IntegrationTable: Record "Integration";
        Contribution: Record "Contribution";
        Txt006: Label 'Are you sure you want to transfer data?';
        Txt007: Label 'Data transffered.';
        WS: Record "Wage Setup";
        "Average Wage - Chamber(triple)": Decimal;
        "For payment - Chamber": Decimal;
        SickHourPool: Integer;
        Employee: Record "Employee";
        canton: Record "Canton";
        ConCat: Record "Contribution Category";
        CompanyInfo: Record "Company Information";
        WPConnSetup: Record "Web portal connection setup";
        /* conn: Automation;
         comm: Automation;
         param: Automation;
         lvarActiveConnection: Variant;*/
        WPConnSetupOB: Record "Web portal connection setup";
        /*connOB: Automation;
        commOB: Automation;
        paramOB: Automation;
        lvarActiveConnectionOB: Variant;*/
        WPConnSetupPL: Record "Web portal connection setup";
        /*connPL: Automation;
        commPL: Automation;
        paramPL: Automation;
        lvarActiveConnectionPL: Variant;*/
        EA: Record "Employee Absence";
        COA: Record "Cause of Absence";
        WageSetup: Record "Wage Setup";
        WPConnSetupRAS: Record "Web portal connection setup";
        /* connRAS: Automation;
         commRAS: Automation;
         paramRAS: Automation;
         lvarActiveConnectionRAS: Variant;*/
        cpe9: Record "Contribution Per Employee";
        cpe2: Record "Contribution Per Employee";
        cpe3: Record "Contribution Per Employee";
        cpe4: Record "Contribution Per Employee";
        cpe5: Record "Contribution Per Employee";
        cpe10: Record "Contribution Per Employee";
        cpe6: Record "Contribution Per Employee";
        cpe7: Record "Contribution Per Employee";
        cpe8: Record "Contribution Per Employee";
        Txt008: Label 'Accounting period opened!';
        Txt009: Label 'Calculation transfered succesfully!';
        Txt010: Label 'Calculation transfered succesfully!';
        Txt011: Label 'Calculation transfered succesfully!';
        wve2: Record "Wage Value Entry";
        AddTaxPE: Record "Contribution Per Employee";
        Txt012: Label 'Do you want to delete calculatio %1? Note that deleting calculation does not reverse posting!';
        ReportName: Text;
        FileVar: File;
        IStream: InStream;
        MagicPath: Text;
        //FileSystemObject: Automation;
        DestinationFileName: Text;
        Txt013: Label 'Postoje obračuni sa negativnom isplatom.';
        PO: Record "Payment Order";

    procedure Replacestring(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;
}

