page 50017 "Wage Header Card"
{
    Caption = 'Wage Header Card';
    DeleteAllowed = false;
    InsertAllowed = false;

    PageType = Card;
    SourceTable = "Wage Header";

    layout
    {
        area(content)
        {
            group(Basic)
            {
                Caption = 'Basic';
                field("No."; "No.")
                {
                }
                field("Year Of Wage"; "Year Of Wage")
                {
                    Editable = false;
                }
                field("Month Of Wage"; "Month Of Wage")
                {
                    Editable = false;
                }
                field("Entry No."; "Entry No.")
                {
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Wage Calculation Type"; "Wage Calculation Type")
                {
                    Editable = false;
                }
                field(Status; Status)
                {
                }
                field("Date Of Calculation"; "Date Of Calculation")
                {
                    Editable = false;
                }
                field("Year of Calculation"; "Year of Calculation")
                {
                    Editable = false;
                }
                field("Month of Calculation"; "Month of Calculation")
                {
                    Editable = false;
                }
                field("Average Wage"; "Average Wage")
                {

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
                                cpe1."Global Dimension 1 Code" := cpe1."Global Dimension 1 Code";
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
                            //WVE."Global Dimension 1 Code":=WLE."Global Dimension 1 Code";
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

                    trigger OnValidate()
                    begin
                        WC.SETFILTER("Wage Header No.", '%1', "No.");
                        IF WC.FIND('-') THEN
                            REPEAT
                                WC."Payment Date" := "Payment Date";
                                WC.MODIFY;
                            UNTIL WC.NEXT = 0;
                    end;
                }
                field("Closing Date"; "Closing Date")
                {
                    Editable = false;
                }

                field("User ID"; "User ID")
                {
                    Editable = false;
                }
                field(Timestamp_WH; Timestamp_WH)
                {
                    Editable = false;
                }
                field("Payment Orders printed"; "Payment Orders printed")
                {
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Brutto Sum"; "Brutto Sum")
                {

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

                                cpe1."Global Dimension 1 Code" := cpe."Global Dimension 1 Code";
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
                            //WVE."Global Dimension 1 Code":=WLE."Global Dimension 1 Code";
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
                    Editable = false;
                }
                field(Transportation; Transportation)
                {
                    Editable = false;
                }
                field(Reduction; Reduction)
                {
                    Editable = false;
                }
            }
            group(Chamber)
            {
                Caption = 'Chamber';
                field("Average Wage - Chamber"; "Average Wage - Chamber")
                {
                }
                field("Average Wage - Chamber(triple)"; "Average Wage - Chamber(triple)")
                {
                    Caption = 'Average Wage - Chamber(triple)';
                }
                field("Chamber Amount"; "Chamber Amount")
                {
                }
            }
            group(Totals)
            {
                Caption = 'Totals';
                field(Brutto; Brutto)
                {
                    Editable = false;
                }
                field("Net Wage"; "Net Wage")
                {
                    Editable = false;
                }
                field("Add. Tax From Brutto"; "Add. Tax From Brutto")
                {
                    Editable = false;
                }
                field("Add. Tax Over Brutto"; "Add. Tax Over Brutto")
                {
                    Editable = false;
                }
                field("Wage Reduction"; "Wage Reduction")
                {
                    Editable = false;
                }
                field("Wage Reduction Loan"; "Wage Reduction Loan")
                {
                    Editable = false;
                }
                field("Wage Reduction Phone"; "Wage Reduction Phone")
                {
                    Editable = false;
                }
                field("Wage Reduction Other"; "Wage Reduction Other")
                {
                    Editable = false;
                }
                field(Transport; Transport)
                {
                    Editable = false;
                }
                field("Meal Amount"; "Meal Amount")
                {
                    Editable = false;
                }
                field("Sick Leave-Company"; "Sick Leave-Company")
                {
                    Editable = false;
                }
                field("Sick Leave-Fund"; "Sick Leave-Fund")
                {
                    Editable = false;
                }
                field("Untaxable Wage"; "Untaxable Wage")
                {
                    Editable = false;
                }
                field("Tax Basis"; "Tax Basis")
                {
                    Editable = false;
                }
                field(Tax; Tax)
                {
                    Editable = false;
                }
                field(Payment; Payment)
                {
                    Editable = false;
                }
            }
            group("Totals TS")
            {
                Caption = 'Totals for Temporary services';
                field("Brutto TS"; "Brutto TS")
                {
                    Editable = false;
                }
                field("Net Wage TS"; "Net Wage TS")
                {
                    Editable = false;
                }
                field("Add. Tax From Brutto TS"; "Add. Tax From Brutto TS")
                {
                    Editable = false;
                }
                field("Add. Tax Over Brutto TS"; "Add. Tax Over Brutto TS")
                {
                    Editable = false;
                }
                field("Tax Basis TS"; "Tax Basis TS")
                {
                    Editable = false;
                }
                field("Tax TS"; "Tax TS")
                {
                    Editable = false;
                }
                field("Payment Date (TS Residents)"; "Payment Date (TS Residents)")
                {

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
                    Editable = false;
                }
                field("Net Wage TS NR"; "Net Wage TS NR")
                {
                    Editable = false;
                }
                field("Add. Tax From Brutto TS NR"; "Add. Tax From Brutto TS NR")
                {
                    Editable = false;
                }
                field("Add. Tax Over Brutto TS NR"; "Add. Tax Over Brutto TS NR")
                {
                    Editable = false;
                }
                field("Tax Basis TS NR"; "Tax Basis TS NR")
                {
                    Editable = false;
                }
                field("Tax TS NR"; "Tax TS NR")
                {
                    Editable = false;
                }
                field("Payment Date (TS No Residents)"; "Payment Date (TS No Residents)")
                {

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
                    Editable = false;
                }
                field("Net Wage TS AC"; "Net Wage TS AC")
                {
                    Editable = false;
                }
                field("Add. Tax From Brutto TS AC"; "Add. Tax From Brutto TS AC")
                {
                    Editable = false;
                }
                field("Add. Tax Over Brutto TS AC"; "Add. Tax Over Brutto TS AC")
                {
                    Editable = false;
                }
                field("Tax Basis TS AC"; "Tax Basis TS AC")
                {
                    Editable = false;
                }
                field("Tax TS AC"; "Tax TS AC")
                {
                    Editable = false;
                }
                field("Payment Date (Author Contract)"; "Payment Date (Author Contract)")
                {

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
            group("Payment Orders2")
            {
                Caption = 'Payment Orders';
                group("Payment Orders")
                {
                    Caption = 'Payment Orders';
                    Image = Payables;
                    action("Priprema Virmana")
                    {
                        Caption = 'Payment Order preparation';
                        Image = Payment;
                        Promoted = false;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = false;

                        trigger OnAction()
                        var
                            WithConfirm: Boolean;
                        begin
                            Municipality.SETFILTER(Code, '<>%1', '');
                            IF Municipality.FIND('-') THEN
                                REPEAT
                                    Municipality."For Calculation" := 0;
                                    Municipality."For Calculation 2" := 0;
                                    Municipality.MODIFY;
                                UNTIL Municipality.NEXT = 0;
                            //WithConfirm := CONFIRM(Txt005,FALSE);
                            CloseWageCalc.POrdersInitValue(Rec, WithConfirm);
                        end;
                    }
                    action("Priprema Virmana - odvojeni obračun dodataka")
                    {
                        Caption = 'un dodataka';
                        Image = Payment;
                        Promoted = false;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = false;

                        trigger OnAction()
                        var
                            WithConfirm: Boolean;
                        begin
                            Municipality.SETFILTER(Code, '<>%1', '');
                            IF Municipality.FIND('-') THEN
                                REPEAT
                                    Municipality."For Calculation" := 0;
                                    Municipality."For Calculation 2" := 0;
                                    Municipality.MODIFY;
                                UNTIL Municipality.NEXT = 0;

                            //WithConfirm := CONFIRM(Txt005,FALSE);

                            /*CloseWageCalc.DoprinosiDodaci(Rec);
                              Municipality.SETFILTER(Code,'<>%1','');
                              IF Municipality.FIND('-') THEN REPEAT
                              Municipality."For Calculation":=0;
                              Municipality."For Calculation 2":=0;
                              Municipality.MODIFY;
                              UNTIL Municipality.NEXT=0;*/


                            /*CloseWageCalc.DoprinosiBDDodaci(Rec);
                              Municipality.SETFILTER(Code,'<>%1','');
                              IF Municipality.FIND('-') THEN REPEAT
                              Municipality."For Calculation":=0;
                              Municipality."For Calculation 2":=0;
                              Municipality.MODIFY;
                              UNTIL Municipality.NEXT=0;
                            
                            CloseWageCalc.DoprinosiFBIHRSDodaci(Rec);
                              Municipality.SETFILTER(Code,'<>%1','');
                              IF Municipality.FIND('-') THEN REPEAT
                              Municipality."For Calculation":=0;
                              Municipality."For Calculation 2":=0;
                              Municipality.MODIFY;
                              UNTIL Municipality.NEXT=0;*/

                            CloseWageCalc.DodaciPoBankama(Rec);
                            //CloseWageCalc.PoreziDodaci(Rec);
                            CloseWageCalc.POrdersInitValue(Rec, WithConfirm);

                        end;
                    }
                    action("Pregled Virmana")
                    {
                        Caption = 'Payment Orders';
                        Image = Check;
                        RunObject = Page 50042;
                    }
                    action("Pregled UPP naloga po poslovnicama")
                    {
                        Caption = 'a';
                        Image = CheckDuplicates;
                        RunObject = Page 99000766;
                        Visible = false;
                    }
                    action("Priprema  UPP naloga - privremeni i povremeni ugovori")
                    {
                        Caption = ' i povremeni ugovori';
                        Image = Payment;
                        Promoted = false;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = false;

                        trigger OnAction()
                        var
                            WithConfirm: Boolean;
                        begin
                            Municipality.SETFILTER(Code, '<>%1', '');
                            IF Municipality.FIND('-') THEN
                                REPEAT
                                    Municipality."For Calculation" := 0;
                                    Municipality."For Calculation 2" := 0;
                                    Municipality.MODIFY;
                                UNTIL Municipality.NEXT = 0;

                            WithConfirm := CONFIRM(Txt005, FALSE);

                            CloseWageCalc.DoprinosiTC(Rec);
                            Municipality.SETFILTER(Code, '<>%1', '');
                            IF Municipality.FIND('-') THEN
                                REPEAT
                                    Municipality."For Calculation" := 0;
                                    Municipality."For Calculation 2" := 0;
                                    Municipality.MODIFY;
                                UNTIL Municipality.NEXT = 0;


                            CloseWageCalc.DoprinosiTCNR(Rec);
                            Municipality.SETFILTER(Code, '<>%1', '');
                            IF Municipality.FIND('-') THEN
                                REPEAT
                                    Municipality."For Calculation" := 0;
                                    Municipality."For Calculation 2" := 0;
                                    Municipality.MODIFY;
                                UNTIL Municipality.NEXT = 0;

                            CloseWageCalc.UOD(Rec);
                            CloseWageCalc.DoprinosiTCAC(Rec);
                            CloseWageCalc.PoreziTC(Rec);
                            CloseWageCalc.PoreziTCNR(Rec);
                            CloseWageCalc.PoreziTCAC(Rec);
                            AddTaxPE.SETFILTER(Calculated, '%1', FALSE);
                            AddTaxPE.SETFILTER("Wage Calculation Type", '%1|%2|%3', 1, 2, 3);
                            IF AddTaxPE.FIND('-') THEN
                                REPEAT
                                    AddTaxPE.Calculated := TRUE;
                                    AddTaxPE.MODIFY;
                                UNTIL AddTaxPE.NEXT = 0;
                        end;
                    }
                }
            }
            group("Journal Creation2")
            {
                Caption = 'Journal Creation';
                Image = Reconcile;
                group("Journal Creation")
                {
                    Caption = 'Journal Creation';
                    Image = Journals;
                    action("Kreiraj nalog za knjiženje")
                    {
                        Caption = 'Tranfer calculation to Gen. Journal';
                        Image = Post;
                        Promoted = false;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = false;

                        trigger OnAction()
                        begin
                            //
                            IF CONFIRM(Txt003, FALSE, Rec.Description) THEN BEGIN
                                WLE.SETRANGE("Document No.", xRec."No.");
                                WLE.SETRANGE("Wage Header Entry No.", xRec."Entry No.");
                                REPORT.RUNMODAL(REPORT::"Post Wage to GL", TRUE, TRUE, WLE);
                            END;
                        end;
                    }

                    action("Pregled naloga za knjiženje")
                    {
                        Caption = 'Look calculation to Gen. Journal';
                        Image = ShowList;
                        Promoted = false;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = false;

                        trigger OnAction()
                        var
                            GenJournal: Page "General Journal";
                        begin


                            GenJournal.Run();



                            /* WLE.SETRANGE("Document No.", xRec."No.");
                             WLE.SETRANGE("Wage Header Entry No.", xRec."Entry No.");
                             REPORT.RUNMODAL(REPORT::"Post Wage to GL", TRUE, TRUE, WLE);*/


                        end;
                    }


                }

            }

            group("Lock calculation3")
            {
                Caption = 'Lock calculation';
                Image = Alerts;
                group("Lock calculation2")
                {
                    Caption = 'Lock calculation';
                    Image = Alerts;
                    action("Zaključi obračun")
                    {
                        Image = Lock;
                        Promoted = true;
                        PromotedIsBig = true;

                        trigger OnAction()
                        begin
                            BEGIN
                                CurrPage.SETSELECTIONFILTER(wh);
                                REPORT.RUNMODAL(REPORT::"Lock Calculation", FALSE, FALSE, wh);
                            END;
                        end;
                    }
                }
            }
            group(Export)


            {
                Caption = 'Export';
                action("Export MIP")


                {

                    Caption = 'Export MIP';
                    Image = ExportFile;
                    trigger OnAction()
                    begin
                        // MIPXML.Run();
                        Xmlport.Run(50001, false, false);
                    end;


                }
                action("Export GIP")
                {
                    Caption = 'Export GIP';
                    Image = ExportFile;
                    trigger OnAction()
                    begin
                        Xmlport.Run(50002, false, false);
                    end;
                }

            }
            group(Delete)
            {
                Caption = 'Delete';
                Image = Confirm;
                group(Delete2)
                {
                    Caption = 'Delete';
                    Image = Confirm;
                    action("Otvori obračun")
                    {
                        Caption = 'Open calculation';
                        Image = OpenWorksheet;
                        Promoted = false;
                        Visible = false;

                        trigger OnAction()
                        begin

                            IF CONFIRM(Txt002, FALSE, Rec.Description) THEN BEGIN
                                CurrPage.SETSELECTIONFILTER(wh);
                                REPORT.RUN(REPORT::"Reopen Calculation", FALSE, FALSE, wh);
                            END;
                        end;
                    }
                    action("Obriši obračun plate")
                    {
                        Caption = 'Delete wage calculation';
                        Image = Delete;
                        Promoted = false;

                        trigger OnAction()
                        begin

                            IF CONFIRM(Txt002, FALSE, Rec.Description) THEN BEGIN
                                IF CONFIRM(Txt012, FALSE, Rec.Description) THEN BEGIN
                                    CurrPage.SETSELECTIONFILTER(wh);
                                    REPORT.RUN(REPORT::"Delete Calculation", FALSE, FALSE, wh);
                                END;
                            END;
                        end;
                    }
                    action("Transfer Data")
                    {
                        Caption = 'Transfer Data';
                        Image = TransferOrder;
                        Promoted = true;
                        PromotedIsBig = false;
                        Visible = false;

                        trigger OnAction()
                        begin
                            /*Response :=CONFIRM(Txt006);
                            IF Response THEN
                              BEGIN
                                IF WC.FINDFIRST THEN REPEAT
                                  BEGIN
                                    SAP.RESET;
                                    SAP.SETFILTER(SAP."Wage Header No.", WC."Wage Header No.");
                                    SAP.SETFILTER(SAP."Wage Calculation No.", WC."No.");
                                    IF SAP.ISEMPTY THEN
                                      BEGIN
                                        SAP."Wage Calculation No.":=WC."No.";
                                        SAP."Wage Header No.":=WC."Wage Header No.";
                                        SAP.JMB:=WC."Employee No.";
                                        SAP.POREZ:=WC.Tax;
                                        SAP.OBUSTAVE_UKUPNO:=WC."Wage Reduction";
                                        SAP.UGOVORENI_BRUTO:=WC."Wage (Base)";
                                        SAP.BRUTO:=WC.Brutto;
                                        SAP.NETO_PLATA:=WC."Net Wage"- WC.Tax;
                                        SAP.IZNOS_ISPLATA:=WC.Payment;
                                        SAP.MINULI_RAD:=WC."Work Experience Brutto";
                                        SAP.UKUPNO_DOPRINOSA_IZ_PLATE:=WC."Contribution From Brutto";
                                        SAP.UKUPNO_DOPRINOSA_NA_PATU:=WC."Contribution Over Brutto";
                                        SAP.TOPLI_OBROK:=WC."Taxable Meal";
                                        SAP.TOPLI_OBROK_NEOP:=WC."Meal to pay";
                                        SAP.TROSKOVI_PREVOZA:=WC."Taxable Transport";
                                        SAP.TROSKOVI_PREVOZA_NEOP:=WC.Transport;
                                        cpe.RESET;
                                        cpe.SETFILTER(cpe."Wage Header No.",WC."Wage Header No.");
                                        cpe.SETFILTER(cpe."Wage Calc No.",WC."No.");
                                        IF cpe.FINDFIRST THEN
                                          BEGIN
                                            cpe.SETFILTER("Contribution Code",'DJEC-ZAST');
                                            IF cpe.FINDFIRST THEN
                                              SAP.DJ_ZASTITA_IZ:=cpe."Amount On Wage";
                                             cpe.SETFILTER("Contribution Code",'D-NEZAP-IZ');
                                            IF cpe.FINDFIRST THEN
                                              SAP.NEZAP_IZ:=cpe."Amount From Wage";
                                             cpe.SETFILTER("Contribution Code",'D-NEZAP-NA');
                                            IF cpe.FINDFIRST THEN
                                              SAP.NEZAP_NA:=cpe."Amount Over Wage";
                                             cpe.SETFILTER("Contribution Code",'D-PIO-IZ');
                                            IF cpe.FINDFIRST THEN
                                              SAP.PIO_IZ:=cpe."Amount From Wage";
                                             cpe.SETFILTER("Contribution Code",'D-PIO-NA');
                                            IF cpe.FINDFIRST THEN
                                              SAP.PIO_NA:=cpe."Amount Over Wage";
                                            cpe.SETFILTER("Contribution Code",'D-ZDRAV-IZ');
                                            IF cpe.FINDFIRST THEN
                                              SAP.ZDR_IZ:=cpe."Amount From Wage";
                                            cpe.SETFILTER("Contribution Code",'D-ZDRAV-NA');
                                            IF cpe.FINDFIRST THEN
                                              SAP.ZDR_NA:=cpe."Amount Over Wage";
                                            cpe.SETFILTER("Contribution Code",'P-VOD');
                                            IF cpe.FINDFIRST THEN
                                              SAP.OPCA_VODNA_NAKNADA:=cpe."Amount On Wage";
                                            cpe.SETFILTER("Contribution Code",'P-ELNEP');
                                            IF cpe.FINDFIRST THEN
                                              SAP.PPZZOPIDN:=cpe."Amount On Wage";
                                          END;
                                        emp.RESET;
                                        emp.SETFILTER("No.",WC."Employee No.");
                                        IF emp.FINDFIRST THEN
                                          BEGIN
                                            SAP.IME_I_PREZIME:= emp."First Name" + ' ' + emp."Last Name";
                                          END;
                                        SAP.UKUPNI_TROSAK:=SAP.BRUTO+SAP.UKUPNO_DOPRINOSA_NA_PATU+SAP.TOPLI_OBROK_NEOP+SAP.TROSKOVI_PREVOZA_NEOP+SAP.REGRES_NEOP+SAP.DOPRINOSI_PRIV_KOM+SAP.PPZZOPIDN+SAP.OPCA_VODNA_NAKNADA+SAP.KORISTI_NETO;
                                        SAP.INSERT;
                                      END;
                                  END;
                            
                                UNTIL WC.NEXT=0;
                                MESSAGE(Txt007)
                            
                              END;*/

                        end;
                    }
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
        //MESSAGE(FORMAT(BruttoSum));
        WS.GET();
    end;

    trigger OnOpenPage()
    begin

        //INT1.0 start
        UTemp.SETFILTER("User ID", '%1', USERID);
        IF UTemp.FINDFIRST THEN
            WageAllowed := UTemp."Wage Allowed";

        IF WageAllowed = FALSE THEN
            ERROR(error1);
        //INT1.0 end
    end;

    var
        R_SetGLE: Report "RUC calculation";
        WageAm: Record "Wage Amounts";
        Department: Record Department;
        EmpDefDim: Record "Employee Default Dimension";
        OrgD: Record "Routing Personnel";
        WA: Record "Wage Addition";
        No: Code[10];
        wh: Record "Wage Header";
        WLE: Record "Wage Ledger Entry";
        WC: Record "Wage Calculation";
        Txt001: Label 'Do you want to close calculation %1?';
        Txt002: Label 'Do you want to delete calculatio %1? Note that deleting calculation does not reverse posting!';
        Txt003: Label 'Do you want to tranfer calculation %1 to Gen. Journal?';
        CloseWageCalc: Codeunit "Close Wage Calculation";
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
        Municipality: Record Municipality;
        Response: Boolean;
        Recapitulation: Record "Standard Task";
        IntegrationTable: Record "Family Line";
        Contribution: Record "Contribution";
        Txt006: Label 'Are you sure you want to transfer data?';
        Txt007: Label 'Data transffered.';
        WS: Record "Wage Setup";
        "Average Wage - Chamber(triple)": Decimal;
        "For payment - Chamber": Decimal;
        SickHourPool: Integer;
        Employee: Record Employee;
        canton: Record Canton;
        ConCat: Record "Contribution Category";
        CompanyInfo: Record "Company Information";
        WPConnSetup: Record "Routing Comment Line";
        lvarActiveConnection: Variant;
        WPConnSetupOB: Record "Routing Comment Line";
        lvarActiveConnectionOB: Variant;
        WPConnSetupPL: Record "Routing Comment Line";

        lvarActiveConnectionPL: Variant;
        EA: Record "Employee Absence";
        COA: Record "Cause of Absence";
        WageSetup: Record "Wage Setup";
        WPConnSetupRAS: Record "Routing Comment Line";
        lvarActiveConnectionRAS: Variant;
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
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
        MIPXML: XmlPort "MIP 1023";
        GIPXML: XmlPort "GIP 1022";
}

