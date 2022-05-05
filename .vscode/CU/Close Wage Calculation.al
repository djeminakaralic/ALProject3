codeunit 50004 "Close Wage Calculation"
{

    trigger OnRun()
    begin
    end;

    var
        CPE1: Record "Contribution Per Employee";
        TPE1: Record "Tax Per Employee";
        WVE1: Record "Wage Value Entry";
        DatumUplate: Date;
        RAmount: Decimal;
        BankNo: Integer;
        AdditionAmountForPaymentMeal: Decimal;
        AbsenceFill: Codeunit "Absence Fill";
        StartDate: Date;
        EndDate: Date;
        EA: Record "Employee Absence";
        WageSetup: Record "Wage Setup";
        WType: Integer;
        Tip: Integer;
        Sifra: Code[50];
        SOLIDAmount: Decimal;
        AmountOver: Decimal;
        TempAmountSpec: Decimal;
        AmountOverTemp: Decimal;
        TempAmountSpecTemp: Decimal;
        AmountOverRed: Decimal;
        Reduction: Record "Reduction per Wage";
        RedReal: Record "Reduction per Wage";
        RedTemp: Record "Reduction per Wage Temp";
        CalcReal: Record "Wage Calculation";
        CalcRealNeg: Record "Wage Calculation";
        CalcReal2: Record "Wage Calculation";
        CalcTemp: Record "Wage Calculation Temp";
        ATReal: Record "Contribution Per Employee";
        ATTemp: Record "Contribution Per Employee Temp";
        TaxReal: Record "Tax Per Employee";
        TaxTemp: Record "Tax Per Employee Temp";
        TransHeader: Record "Transport Header";
        TransLine: Record "Transport Line";
        TransLineTemp: Record "Transport Line Temp";
        MealHeader: Record "Meal Header";
        MealLine: Record "Meal Line";
        MealLineTemp: Record "Meal Line Temp";
        WVE: Record "Wage Value Entry";
        WLE: Record "Wage Ledger Entry";
        Employee: Record "Employee";
        ATax: Record "Contribution";
        RedMain: Record "Reduction";
        Rec: Record "Wage Header";
        Post: Record "Post Code";
        WageType: Record "Wage Type";
        RedMainFD: Record "Reduction";
        RedLineFD: Record "Reduction per Wage";
        RedType: Record "Reduction Types";
        WageAddition: Record "Wage Addition";
        AF: Codeunit "Absence Fill";
        Window: Dialog;
        CurrRecNo: Integer;
        TotalRecNo: Integer;
        ValueEntryNo: Integer;
        LedgerEntryNo: Integer;
        PostingDate: Date;
        ValueEntriesExist: Boolean;
        Desc: Text[50];
        PostingGroup: Code[10];
        RedLockFlag: Boolean;
        ____VIRMANI: Integer;
        SvrhaDoznake1: Text[150];
        SvrhaDoznake2: Text[50];
        SvrhaDoznake3: Text[50];
        Primalac1: Text[50];
        Primalac2: Text[50];
        Primalac3: Text[50];
        RacunPosiljaoca: Text[16];
        RacunPrimaoca: Text[16];
        Iznos: Decimal;
        BrojPoreznogObaveznika: Text[14];
        VrstaPrihoda: Text[6];
        Opstina: Text[5];
        PozivNaBroj: Text[10];
        PorezniPeriodOd: Date;
        PorezniPeriodDo: Date;
        CompanyInfo: Record "Company Information";
        BankAccount: Record "Bank Account";
        BankCode: Code[20];
        WHeaderNo: Code[20];
        WHeaderEntryNo: Integer;
        WPaymentType: Option " ",Wage,"Add. Tax",Tax,Reduction,Chamber;
        CompInfo: Record "Company Information";
        BankAccounts: Record "Bank Account";
        POrders: Record "Payment Order";
        WithConfirm: Boolean;
        Txt001: Label 'Are you sure you wish to close this calculation?';
        Txt002: Label 'Program code is not defined for wage type for employee %1!';
        Txt006: Label 'Are you sure you wish to return to previous step?';
        Txt003: Label 'Wage Calculation %1 from %2-%3 for %4';
        Txt004: Label '%1 for %2, W.C.%3';
        Txt005: Label 'Wage Calculation is now closed';
        NoTest: Code[10];
        Temp: Record "Wage Calculation";
        i: Integer;
        Contribution: Text[150];
        Txt0061: Label 'Payment orders are prepared.';
        Txt007: Label 'Closing wage (1/7)\@1@@@@@@@@@@@@@@@@@@@@@  ::Employees\';
        Txt008: Label 'Closing wage (2/7)\@1@@@@@@@@@@@@@@@@@@@@@  ::Employees\';
        Txt009: Label 'Closing wage (3/7)\@1@@@@@@@@@@@@@@@@@@@@@  ::Employees\';
        Txt010: Label 'Closing wage (4/7)\@1@@@@@@@@@@@@@@@@@@@@@  ::Employees\';
        Txt011: Label 'Closing wage (5/7)\@1@@@@@@@@@@@@@@@@@@@@@  ::Employees\';
        Txt012: Label 'Closing wage (6/7)\@1@@@@@@@@@@@@@@@@@@@@@  ::Employees\';
        Txt013: Label 'Closing wage (7/7)\@1@@@@@@@@@@@@@@@@@@@@@  ::Employees\';
        Txt014: Label 'Calculatin for chosen period already exists!';
        Txt015: Label 'Payment orders are printed for this calculation!';
        Emp: Record "Employee";
        WC: Record "Wage Calculation Temp";
        RegresAmount: Decimal;
        WageAdditionTaxable: Record "Wage Addition";
        OrgDio: Code[10];
        Department: Record Department;
        POrdersbyBO: Record "Routing Header";
        M: Record Municipality;
        BranchOfficeCode: Text;
        OD: Record "Routing Personnel";
        WA: Record "Wage Addition";
        WageAdditionAmount: Decimal;

    procedure ResetTables()
    begin
        RedReal.RESET;
        CalcReal.RESET;
        ATReal.RESET;
        TaxReal.RESET;
        TransHeader.RESET;
        TransLine.RESET;
        MealHeader.RESET;
        MealLine.RESET;
        CalcTemp.RESET;
        RedTemp.RESET;
        ATTemp.RESET;
        TaxTemp.RESET;
        TransLineTemp.RESET;
        MealLineTemp.RESET;
        WLE.RESET;
        WVE.RESET;
        Employee.RESET;
    end;

    procedure FillLedger()
    var
        EmplDefDim: Record "Employee Default Dimension";
        GLSetup: Record "General Ledger Setup";
    begin
        IF ValueEntryNo = 0 THEN BEGIN
            WVE.LOCKTABLE;
            IF WVE.FIND('+') THEN
                ValueEntryNo := WVE."Entry No.";
        END;
        IF LedgerEntryNo = 0 THEN BEGIN
            WLE.LOCKTABLE;
            IF WLE.FIND('+') THEN
                LedgerEntryNo := WLE."Entry No.";
        END;
        IF PostingDate = 0D THEN
            PostingDate := AF.GetMonthRange(Rec."Month Of Wage", Rec."Year Of Wage", FALSE);


        CalcTemp.SETRANGE("Wage Header No.", Rec."No.");
        CalcTemp.SETRANGE("Entry No.", Rec."Entry No.");



        Window.OPEN('Obrada obračuna plata\@1@@@@@@@@@@@@@@@@@@@@@  ::Radnici\');
        Window.UPDATE(1, 0);

        CurrRecNo := 0;
        TotalRecNo := CalcTemp.COUNTAPPROX;

        IF CalcTemp.FINDFIRST THEN
            REPEAT
                CurrRecNo += 1;
                Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));

                /*WLE.SETFILTER("Document No.", Rec."No.");
                WLE.SETFILTER("Employee No.", CalcTemp."Employee No.");*/

                Employee.GET(CalcTemp."Employee No.");
                Post.GET(Employee."Post Code", Employee.City);

                PostingGroup := Employee."Wage Posting Group";

                //IF NOT WLE.FINDFIRST THEN
                BEGIN
                    LedgerEntryNo := LedgerEntryNo + 1;
                    Employee.TESTFIELD("Wage Posting Group");
                    Employee.TESTFIELD("Post Code");



                    WLE.INIT;
                    WLE."Entry No." := LedgerEntryNo;
                    WLE."Wage Header Entry No." := Rec."Entry No.";
                    WLE."Employee No." := CalcTemp."Employee No.";
                    WLE."Document No." := Rec."No.";
                    WLE.Description := COPYSTR(STRSUBSTNO(Txt003, Rec."No.", Rec."Month Of Wage", Rec."Year Of Wage",
                                         Employee."No."), 1, MAXSTRLEN(WLE.Description));
                    WLE.Open := TRUE;
                    WLE."Global Dimension 1 Code" := CalcTemp."Global Dimension 1 Code";
                    WLE."Global Dimension 2 Code" := CalcTemp."Global Dimension 2 Code";
                    // WLE."Shortcut Dimension 4 Code":=CalcTemp."Shortcut Dimension 4 Code";
                    WLE."Document Date" := Rec."Date Of Calculation";
                    WLE."Posting Date" := PostingDate;
                    WLE."No. Series" := '';
                    WLE."Month Of Calculation" := Rec."Month of Calculation";
                    WLE."Year Of Calculation" := Rec."Year of Calculation";
                    WLE."Month Of Wage" := Rec."Month Of Wage";
                    WLE."Year Of Wage" := Rec."Year Of Wage";



                    WageType.GET(Employee."Wage Type");
                    WLE."Wage Type" := WageType.Code;
                    WLE."Contracted Work" := WageType.Contract;

                    WLE.INSERT;
                END;


                ValueEntriesExist := FALSE;


                /*Desc:= COPYSTR(STRSUBSTNO(Txt004, 'Prirez', WLE."Employee No.", Rec."No."),1, MAXSTRLEN(Desc));
                InsertValueEntry(Desc,WVE."Entry Type"::"Added Tax Per City",CalcTemp."Added Tax Per City",'',
                ValueEntriesExist,0,CalcTemp.Type);*/

                Desc := COPYSTR(STRSUBSTNO(Txt004, 'Porez', WLE."Employee No.", Rec."No."), 1, MAXSTRLEN(Desc));

                IF ((CalcTemp."Contribution Category Code" = 'FBIHRS') OR (CalcTemp."Contribution Category Code" = 'BDPIORS')) THEN
                    InsertValueEntry(Desc, WVE."Entry Type"::Tax, CalcTemp.Tax, '',
                        ValueEntriesExist, 0)
                ELSE
                    InsertValueEntry(Desc, WVE."Entry Type"::Tax, CalcTemp.Tax, '',
                    ValueEntriesExist, 0);

                Desc := COPYSTR(STRSUBSTNO(Txt004, 'Neto plaća', WLE."Employee No.", Rec."No."), 1, MAXSTRLEN(Desc));
                //NK    InsertValueEntry(Desc,WVE."Entry Type"::"Net Wage",CalcTemp."Net Wage After Tax",'',ValueEntriesExist,0);
                CalcTemp.CALCFIELDS("Use Netto");
                IF ((CalcTemp."Contribution Category Code" = 'FBIHRS') OR (CalcTemp."Contribution Category Code" = 'BDPIORS')) THEN BEGIN
                    IF (CalcTemp.Brutto - CalcTemp."Contribution From Brutto" - CalcTemp.Tax - CalcTemp."Wage Reduction") > 0 THEN
                        InsertValueEntry(Desc, WVE."Entry Type"::"Net Wage", CalcTemp.Brutto - CalcTemp."Contribution From Brutto" - CalcTemp.Tax - CalcTemp."Wage Reduction", '', ValueEntriesExist, 0);
                END
                ELSE BEGIN
                    IF (CalcTemp."Net Wage After Tax" - CalcTemp."Use Netto" - CalcTemp."Wage Reduction") > 0 THEN
                        InsertValueEntry(Desc, WVE."Entry Type"::"Net Wage", CalcTemp."Net Wage After Tax" - CalcTemp."Use Netto" - CalcTemp."Wage Reduction", '', ValueEntriesExist, 0);
                END;
                Desc := COPYSTR(STRSUBSTNO(Txt004, 'Topli Obrok za isplatu', WLE."Employee No.", Rec."No."), 1, MAXSTRLEN(Desc));
                IF ((CalcTemp."Contribution Category Code" <> 'BDPIOFBIH') AND (CalcTemp."Contribution Category Code" <> 'BDPIORS')) THEN
                    InsertValueEntry(Desc, WVE."Entry Type"::"Meal to pay", CalcTemp."Meal to pay", '', ValueEntriesExist, 0);
                //NK ELSE
                //NK InsertValueEntry(Desc,WVE."Entry Type"::"Net Wage",CalcTemp."Meal to pay",'',ValueEntriesExist,0);


                Desc := COPYSTR(STRSUBSTNO(Txt004, 'Topli Obrok za refundaciju', WLE."Employee No.", Rec."No."), 1, MAXSTRLEN(Desc));
                InsertValueEntry(Desc, WVE."Entry Type"::"Meal to refund", CalcTemp."Meal to refund", '', ValueEntriesExist, 0);

                Desc := COPYSTR(STRSUBSTNO(Txt004, 'Prijevoz', WLE."Employee No.", Rec."No."), 1, MAXSTRLEN(Desc));
                IF ((CalcTemp."Contribution Category Code" <> 'BDPIOFBIH') AND (CalcTemp."Contribution Category Code" <> 'BDPIORS')) THEN
                    InsertValueEntry(Desc, WVE."Entry Type"::Transport, CalcTemp.Transport, '', ValueEntriesExist, 0);

                CalcTemp.CALCFIELDS("Use Netto");
                Desc := COPYSTR(STRSUBSTNO(Txt004, 'Koristi', WLE."Employee No.", Rec."No."), 1, MAXSTRLEN(Desc));
                InsertValueEntry(Desc, WVE."Entry Type"::Use, CalcTemp."Use Netto", '', ValueEntriesExist, 0);

                /* Desc:= COPYSTR(STRSUBSTNO(Txt004, 'Bolovanje-poduzeće', WLE."Employee No.", Rec."No."),1, MAXSTRLEN(Desc));
                 InsertValueEntry(Desc,WVE."Entry Type"::"Sick Leave-Company",CalcTemp."Sick Leave-Company",'',
                 ValueEntriesExist,0);

                 Desc:= COPYSTR(STRSUBSTNO(Txt004, 'Bolovanje-zavod', WLE."Employee No.", Rec."No."),1, MAXSTRLEN(Desc));
                 InsertValueEntry(Desc,WVE."Entry Type"::"Sick Leave-Fund",CalcTemp."Sick Leave-Fund",'',ValueEntriesExist,0);        */

                ATTemp.RESET;
                ATTemp.SETFILTER("Employee No.", WLE."Employee No.");
                ATTemp.SETFILTER("Wage Header No.", Rec."No.");
                ATTemp.SETRANGE("Entry No.", Rec."Entry No.");
                ATTemp.SETRANGE("Global Dimension 1 Code", CalcTemp."Global Dimension 1 Code");
                ATTemp.SETRANGE("Global Dimension 2 Code", CalcTemp."Global Dimension 2 Code");
                //ATTemp.SETRANGE("Shortcut Dimension 4 Code", CalcTemp."Shortcut Dimension 4 Code");

                ATTemp.SETFILTER("Amount From Wage", '<>0');
                IF ATTemp.FINDFIRST THEN
                    REPEAT
                        ATax.GET(ATTemp."Contribution Code");
                        Desc := COPYSTR(STRSUBSTNO(Txt004, ATax.Description, WLE."Employee No.", Rec."No."), 1, MAXSTRLEN(Desc));
                        IF ((CalcTemp."Contribution Category Code" = 'FBIHRS')) THEN BEGIN
                            WageSetup.GET;


                            IF ((ATax.Code = 'D-NEZAP-IZ')) THEN
                                InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                                 ATTemp."Reported Amount From Wage" + (ATTemp."Amount From Wage" * WageSetup."Unemployment Federation" / 100), ATax.Code,
                                                 ValueEntriesExist, ATTemp.Basis);

                            IF ((ATax.Code = 'D-ZDRAV-IZ')) THEN
                                InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                                 ATTemp."Reported Amount From Wage" + (ATTemp."Amount From Wage" * WageSetup."Health Federation" / 100), ATax.Code,
                                                 ValueEntriesExist, ATTemp.Basis);

                            IF ((ATax.Code = 'D-PIO-NA') OR (ATax.Code = 'D-PIO-IZ')) THEN
                                InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                                        ATTemp."Amount From Wage", ATax.Code,
                                                        ValueEntriesExist, ATTemp.Basis)
                        END
                        ELSE BEGIN
                            InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                             ATTemp."Amount From Wage", ATax.Code,
                                             ValueEntriesExist, ATTemp.Basis)
                        END;
                    UNTIL ATTemp.NEXT = 0;
                ATTemp.RESET;
                ATTemp.SETFILTER("Employee No.", Employee."No.");
                ATTemp.SETFILTER("Wage Header No.", Rec."No.");
                ATTemp.SETRANGE("Global Dimension 1 Code", CalcTemp."Global Dimension 1 Code");
                ATTemp.SETRANGE("Global Dimension 2 Code", CalcTemp."Global Dimension 2 Code");
                // ATTemp.SETRANGE("Shortcut Dimension 4 Code", CalcTemp."Shortcut Dimension 4 Code");

                ATTemp.SETRANGE("Entry No.", Rec."Entry No.");
                ATTemp.SETFILTER("Amount Over Wage", '<>0');
                IF ATTemp.FINDFIRST THEN
                    REPEAT
                        ATax.GET(ATTemp."Contribution Code");
                        Desc := COPYSTR(STRSUBSTNO(Txt004, ATax.Description, WLE."Employee No.", Rec."No."), 1, MAXSTRLEN(Desc));
                        IF ((CalcTemp."Contribution Category Code" = 'FBIHRS')) THEN BEGIN
                            WageSetup.GET;
                            IF ((ATax.Code = 'D-NEZAP-NA')) THEN
                                InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                                 ATTemp."Reported Amount From Wage" + (ATTemp."Amount Over Wage" * WageSetup."Unemployment Federation" / 100), ATax.Code,
                                                 ValueEntriesExist, ATTemp.Basis);
                            IF ((ATax.Code = 'D-ZDRAV-NA')) THEN
                                InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                                 ATTemp."Reported Amount From Wage" + (ATTemp."Amount Over Wage" * WageSetup."Health Federation" / 100), ATax.Code,
                                                 ValueEntriesExist, ATTemp.Basis);
                            IF ((ATax.Code = 'D-PIO-NA')) THEN
                                InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                                        ATTemp."Amount Over Wage", ATax.Code,
                                                        ValueEntriesExist, ATTemp.Basis)

                        END
                        ELSE BEGIN
                            //NK2005  IF ((CalcTemp."Contribution Category Code"<>'FBIHRS') ) THEN
                            InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                             ATTemp."Amount Over Wage", ATax.Code,
                                             ValueEntriesExist, ATTemp.Basis);
                        END;
                    UNTIL ATTemp.NEXT = 0;

                ATTemp.RESET;
                ATTemp.SETFILTER("Employee No.", Employee."No.");
                ATTemp.SETFILTER("Wage Header No.", Rec."No.");
                ATTemp.SETRANGE("Global Dimension 1 Code", CalcTemp."Global Dimension 1 Code");
                ATTemp.SETRANGE("Global Dimension 2 Code", CalcTemp."Global Dimension 2 Code");
                // ATTemp.SETRANGE("Shortcut Dimension 4 Code", CalcTemp."Shortcut Dimension 4 Code");

                ATTemp.SETRANGE("Entry No.", Rec."Entry No.");
                ATTemp.SETFILTER("Amount Over Neto", '<>0');
                IF ATTemp.FINDFIRST THEN
                    REPEAT

                        ATax.GET(ATTemp."Contribution Code");
                        Desc := COPYSTR(STRSUBSTNO(Txt004, ATax.Description, WLE."Employee No.", Rec."No."), 1, MAXSTRLEN(Desc));



                        //NK2005IF ((CalcTemp."Contribution Category Code"<>'FBIHRS')) THEN
                        InsertValueEntry(Desc, WVE."Entry Type"::Contribution,
                                         ATTemp."Amount Over Neto", ATax.Code,
                                         ValueEntriesExist, ATTemp.Basis)
                    UNTIL ATTemp.NEXT = 0;


                RedTemp.RESET;
                RedTemp.SETFILTER("Wage Header No.", Rec."No.");
                RedTemp.SETFILTER("Employee No.", CalcTemp."Employee No.");

                GLSetup.GET;

                EmplDefDim.RESET;
                EmplDefDim.SETRANGE("No.", Employee."No.");
                EmplDefDim.SETRANGE("Dimension Code", GLSetup."Global Dimension 1 Code");
                EmplDefDim.SETRANGE("Dimension Value Code", CalcTemp."Global Dimension 1 Code");
                EmplDefDim.FINDFIRST;

                IF RedTemp.FINDFIRST THEN
                    REPEAT
                        RedMain.GET(RedTemp."Reduction No.");
                        Desc := COPYSTR(STRSUBSTNO(Txt004, RedMain.Description, WLE."Employee No.", Rec."No."), 1, MAXSTRLEN(Desc));
                        InsertValueEntry(Desc, WVE."Entry Type"::Reduction, RedTemp.Amount * EmplDefDim."Amount Distribution Coeff."
                                         , '', ValueEntriesExist, 0);
                    UNTIL RedTemp.NEXT = 0;

                WageAddition.RESET;
                WageAddition.SETRANGE("Wage Header No.", Rec."No.");
                WageAddition.SETRANGE("Wage Header Entry No.", Rec."Entry No.");
                WageAddition.SETRANGE("Employee No.", CalcTemp."Employee No.");
                WageAddition.SETRANGE(Taxable, FALSE);
                IF WageAddition.FINDFIRST THEN
                    REPEAT
                        Desc := COPYSTR(STRSUBSTNO(Txt004, WageAddition.Description, WLE."Employee No.", Rec."No."), 1, MAXSTRLEN(Desc));
                        InsertValueEntry(Desc, WVE."Entry Type"::Untaxable, WageAddition."Calculated Amount", '', ValueEntriesExist, 0);
                    UNTIL WageAddition.NEXT = 0;


                WageAdditionTaxable.RESET;
                WageAdditionTaxable.SETRANGE("Wage Header No.", Rec."No.");
                WageAdditionTaxable.SETRANGE("Wage Header Entry No.", Rec."Entry No.");
                WageAdditionTaxable.SETRANGE("Employee No.", CalcTemp."Employee No.");
                WageAdditionTaxable.SETRANGE(Taxable, TRUE);
                IF WageAdditionTaxable.FINDFIRST THEN
                    REPEAT
                        Desc := COPYSTR(STRSUBSTNO(Txt004, WageAdditionTaxable.Description, WLE."Employee No.", Rec."No."), 1, MAXSTRLEN(Desc));
                        InsertValueEntry(Desc, WVE."Entry Type"::Taxable, WageAdditionTaxable."Calculated Amount", '', ValueEntriesExist, 0);
                    UNTIL WageAdditionTaxable.NEXT = 0;
            /*
            WVE.RESET;
            WVE.SETRANGE("Wage Ledger Entry No.",WLE."Entry No.");
            IF WVE.ISEMPTY THEN
              BEGIN
                IF WLE."Entry No." = LedgerEntryNo THEN
                  LedgerEntryNo:=LedgerEntryNo - 1;
                WLE.DELETE;
              END;
             */
            UNTIL CalcTemp.NEXT = 0;
        Window.CLOSE;

    end;

    procedure CloseCalc(Header: Record "Wage Header")
    var
        TransLineStatus: Boolean;
        TransTempStatus: Boolean;
    begin
        Rec := (Header);

        ResetTables();

        FillLedger();

        ResetTables();

        Window.OPEN(Txt007);
        Window.UPDATE(1, 0);

        CurrRecNo := 0;
        TotalRecNo := CalcTemp.COUNTAPPROX;
        Header.CALCFIELDS(Brutto);

        IF ((Header."Wage Calculation Type" = Header."Wage Calculation Type"::Normal) OR
           ((Header."Wage Calculation Type" = Header."Wage Calculation Type"::"Fixed Add") AND (Header.Brutto <> 0))) THEN BEGIN

            IF Temp.FINDLAST THEN
                NoTest := INCSTR(NoTest)
            ELSE
                NoTest := '1';

            IF CalcTemp.FINDFIRST THEN BEGIN
                REPEAT
                    CurrRecNo += 1;
                    Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));


                    /*CalcReal2.SETRANGE("Month Of Wage",CalcTemp."Month Of Wage");
                    CalcReal2.SETRANGE("Year of Wage",CalcTemp."Year Of Wage");

                     IF NOT CalcReal2.FIND('+') THEN*/

                    CalcReal.TRANSFERFIELDS(CalcTemp, FALSE);



                    //CalcReal."No." := NoTest;
                    CalcReal."No." := CalcTemp."No.";
                    //CalcReal."No." := NoTest;
                    CalcReal."No." := CalcTemp."No.";
                    CalcReal."Wage Header No." := CalcTemp."Wage Header No.";
                    CalcReal."Wage Calculation Type" := CalcTemp."Wage Calculation Type";
                    //WG01
                    IF Employee.GET(CalcTemp."Employee No.") THEN BEGIN
                        Employee.CALCFIELDS("Contracted Work");
                        CalcReal."Employee No." := CalcTemp."Employee No.";
                        CalcReal."Contracted Work" := Employee."Contracted Work";
                        CalcReal."Meal to pay" := CalcTemp."Meal to pay";

                        CalcReal.INSERT;

                    END;
                UNTIL CalcTemp.NEXT = 0;

                StartDate := AbsenceFill.GetMonthRange(Header."Month Of Wage", Header."Year Of Wage", TRUE);
                EndDate := AbsenceFill.GetMonthRange(Header."Month Of Wage", Header."Year Of Wage", FALSE);


                Emp.SETFILTER("For Calculation", '%1', TRUE);
                IF Emp.FINDFIRST THEN
                    REPEAT

                        EA.SETFILTER("From Date", '%1..%2', StartDate, EndDate);
                        EA.SETFILTER(Calculated, '%1', FALSE);
                        EA.SETFILTER("Employee No.", Emp."No.");

                        IF EA.FIND('-') THEN
                            REPEAT
                            BEGIN
                                CalcTemp.RESET;
                                CalcTemp.SETFILTER("Employee No.", EA."Employee No.");
                                //CalcTemp.SETFILTER("Month Of Wage",'%1',DATE2DMY(EA."From Date",2));
                                //MESSAGE(FORMAT(CalcTemp."Employee No."));
                                //CalcTemp.SETFILTER("Year Of Wage",'%1',DATE2DMY(EA."From Date",3));
                                //MESSAGE(FORMAT(CalcTemp."Employee No."));
                                IF CalcTemp.FIND('-') THEN BEGIN
                                    EA."Wage Header No." := CalcTemp."Wage Header No.";
                                    EA."Wage Calculation No." := CalcTemp."No.";
                                    EA.Calculated := TRUE;
                                    EA.MODIFY;
                                END;
                            END;
                            UNTIL EA.NEXT = 0;
                    UNTIL Emp.NEXT = 0;
                CalcTemp.DELETEALL;
            END;

            IF ((Header."Wage Calculation Type" = Header."Wage Calculation Type"::"Fixed Add") AND (Header.Brutto = 0)) THEN
                CalcTemp.DELETEALL;

            //WGA01
            /*nk CalcRealNeg.SETRANGE("Month Of Wage",CalcReal."Month Of Wage");
            CalcRealNeg.SETRANGE("Year of Wage",CalcReal."Year of Wage");
            CalcRealNeg.SETRANGE("Employee No.",CalcReal."Employee No.");
            CalcRealNeg.SETFILTER(Payment,'<%1',0);
            IF CalcRealNeg.FIND('-')
            THEN ERROR('Postoje negativne isplate u obračunu!')
            ELSE BEGIN*/

            CalcReal2.SETRANGE("Month Of Wage", CalcReal."Month Of Wage");
            CalcReal2.SETRANGE("Year of Wage", CalcReal."Year of Wage");
            CalcReal2.SETRANGE("Employee No.", CalcReal."Employee No.");
            IF CalcReal2.FIND('-') THEN
                REPEAT

                    CalcTemp.TRANSFERFIELDS(CalcReal2, FALSE);
                UNTIL CalcReal2.NEXT = 0;

            Window.CLOSE;
            Window.OPEN(Txt008);
            Window.UPDATE(1, 0);

            CurrRecNo := 0;
            TotalRecNo := RedTemp.COUNTAPPROX;

            IF RedTemp.FINDFIRST THEN BEGIN
                REPEAT
                    CurrRecNo += 1;
                    Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));

                    RedReal.TRANSFERFIELDS(RedTemp, FALSE);
                    RedReal."No." := RedTemp."No.";
                    RedReal.INSERT;
                UNTIL RedTemp.NEXT = 0;
                RedTemp.DELETEALL;
            END;
            Window.CLOSE;
            Window.OPEN(Txt009);
            Window.UPDATE(1, 0);

            CurrRecNo := 0;
            TotalRecNo := ATTemp.COUNTAPPROX;

            IF ATTemp.FINDFIRST THEN BEGIN
                REPEAT
                    CurrRecNo += 1;
                    Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));

                    ATReal.TRANSFERFIELDS(ATTemp, FALSE);
                    ATReal."Employee No." := ATTemp."Employee No.";
                    //nk
                    ATReal."Wage Calc No." := ATTemp."Wage Calc No.";
                    ATReal."Wage Header No." := ATTemp."Wage Header No.";
                    ATReal."Contribution Code" := ATTemp."Contribution Code";
                    ATReal.INSERT;
                UNTIL ATTemp.NEXT = 0;
                ATTemp.DELETEALL;
            END;
            Window.CLOSE;
            Window.OPEN(Txt010);
            Window.UPDATE(1, 0);

            CurrRecNo := 0;
            TotalRecNo := TaxTemp.COUNTAPPROX;

            IF TaxTemp.FINDFIRST THEN BEGIN
                REPEAT
                    CurrRecNo += 1;
                    Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));

                    TaxReal.TRANSFERFIELDS(TaxTemp, FALSE);
                    TaxReal."Wage Calculation No." := TaxTemp."Wage Calculation No.";
                    TaxReal."Wage Header No." := TaxTemp."Wage Header No.";
                    TaxReal."Contribution Category Code" := TaxTemp."Contribution Category Code";
                    TaxReal."Tax Code" := TaxTemp."Tax Code";
                    TaxReal.INSERT;
                UNTIL TaxTemp.NEXT = 0;
                TaxTemp.DELETEALL;
            END;
            Window.CLOSE;
            IF Header.Reduction THEN BEGIN

                RedMainFD.RESET;
                RedMainFD.SETRANGE(RedMainFD.Status, RedMainFD.Status::Otvoren);

                Window.OPEN(Txt011);
                Window.UPDATE(1, 0);

                CurrRecNo := 0;
                TotalRecNo := RedMainFD.COUNTAPPROX;

                IF RedMainFD.FINDFIRST THEN
                    REPEAT
                        CurrRecNo += 1;
                        Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));

                        RedLockFlag := TRUE;
                        IF RedType.GET(RedMainFD.Type) THEN
                            IF RedType.AmountWithoutLimit THEN
                                RedLockFlag := FALSE;

                        RedLineFD.RESET;
                        RedLineFD.SETFILTER("Reduction No.", RedMainFD."No.");
                        RedLineFD.SETFILTER("Wage Header No.", Header."No.");
                        RedLineFD.MODIFYALL(Locked, TRUE);

                        IF RedLockFlag THEN BEGIN
                            RedMainFD.CALCFIELDS("No. of Installments paid", "Paid Amount");
                            IF ((RedMainFD."No. of Installments" > 0) AND (RedMainFD."No. of Installments paid" >= RedMainFD."No. of Installments")) OR
                               ((RedMainFD."Reduction Amount" > 0) AND (RedMainFD."Paid Amount" >= RedMainFD."Reduction Amount")
                               OR ((RedMainFD."Payment Start" <= Header."Closing Date") AND (RedMainFD."Payment End" <= Header."Closing Date"))) THEN BEGIN
                                RedMainFD.Status := RedMainFD.Status::Zatvoren;
                                RedMainFD.MODIFY;
                            END;
                        END;
                    UNTIL RedMainFD.NEXT = 0;
                Window.CLOSE;
            END;

            IF Header.Transportation THEN BEGIN
                Window.OPEN(Txt012);
                Window.UPDATE(1, 0);

                TransHeader.RESET;
                TransHeader.SETFILTER("Year of Wage", '%1', Rec."Year Of Wage");
                TransHeader.SETFILTER("Month Of Wage", '%1', Rec."Month Of Wage");
                TransHeader.FINDFIRST;
                TransLineTemp.SETFILTER("Document No.", TransHeader."No.");

                CurrRecNo := 0;
                TotalRecNo := TransLineTemp.COUNTAPPROX;

                IF TransLineTemp.FINDFIRST THEN BEGIN
                    REPEAT
                        CurrRecNo += 1;
                        Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));

                        TransLine.SETFILTER("Document No.", TransHeader."No.");
                        TransLine.SETFILTER("Employee No.", TransLineTemp."Employee No.");
                        IF TransLine.FINDFIRST THEN BEGIN
                            TransLine.Amount := TransLine.Amount + TransLineTemp.Amount;
                            TransLine.MODIFY;
                        END
                        ELSE BEGIN
                            TransLine.TRANSFERFIELDS(TransLineTemp, FALSE);
                            TransLine."Line No." := TransLineTemp."Line No.";
                            TransLine."Document No." := TransLineTemp."Document No.";
                            TransLine.INSERT;
                        END;
                    UNTIL TransLineTemp.NEXT = 0;
                    TransLineTemp.DELETEALL;
                END;
                Window.CLOSE;
            END;

            IF Header.Reduction THEN BEGIN
                Window.OPEN(Txt013);
                Window.UPDATE(1, 0);

                MealHeader.RESET;
                MealHeader.SETFILTER("Year Of Wage", '%1', Rec."Year Of Wage");
                MealHeader.SETFILTER("Month Of Wage", '%1', Rec."Month Of Wage");
                MealHeader.FINDFIRST;
                MealLineTemp.SETFILTER("Document No.", MealHeader."No.");

                CurrRecNo := 0;
                TotalRecNo := MealLineTemp.COUNTAPPROX;

                IF MealLineTemp.FINDFIRST THEN BEGIN
                    REPEAT
                        CurrRecNo += 1;
                        Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));

                        MealLine.SETFILTER("Document No.", MealHeader."No.");
                        MealLine.SETFILTER("Employee No.", MealLineTemp."Employee No.");
                        IF MealLine.FINDFIRST THEN BEGIN
                            MealLine.Amount := MealLine.Amount + MealLineTemp.Amount;
                            MealLine.MODIFY;
                        END
                        ELSE BEGIN
                            MealLine.TRANSFERFIELDS(MealLineTemp, FALSE);
                            MealLine."Line No." := MealLineTemp."Line No.";
                            MealLine."Document No." := MealLineTemp."Document No.";
                            MealLine.INSERT;
                        END;
                    UNTIL MealLineTemp.NEXT = 0;
                    MealLineTemp.DELETEALL;
                END;
                Window.CLOSE;
            END;
            //WG

            StartDate := AbsenceFill.GetMonthRange(Header."Month Of Wage", Header."Year Of Wage", TRUE);
            EndDate := AbsenceFill.GetMonthRange(Header."Month Of Wage", Header."Year Of Wage", FALSE);



            /*IF EA.FIND('-') THEN REPEAT
            BEGIN
            EA."Wage Header No.":=CalcTemp."Wage Header No.";
            EA."Wage Calculation No.":=CalcTemp."No.";
            EA.Calculated:=TRUE;
            EA.MODIFY;
            END;

            UNTIL EA.NEXT=0; */


            //Header.Status:= 2;
            Header."Closing Date" := WORKDATE;
            Header."Posting Date" := PostingDate;
            Header."User ID" := USERID;
            Header.Timestamp_WH := CURRENTDATETIME;
            Header.MODIFY;
            MESSAGE(Txt005);

        END;
        //END;

    end;

    procedure InsertValueEntry(TextString: Text[50]; EntryType: Option Tax,"Contribution Per City","Net Wage","Additional Tax"," Sick Leave"; Amount: Decimal; "Contribution Code": Code[10]; var EntriesExist: Boolean; Basis: Decimal)
    begin
        IF Amount = 0 THEN
            EXIT;
        ValueEntryNo := ValueEntryNo + 1;
        WVE.INIT;
        WVE."Entry No." := ValueEntryNo;
        WVE."Employee No." := WLE."Employee No.";
        Employee.GET(WLE."Employee No.");
        WVE."Document No." := Rec."No.";
        WVE."Wage Header Entry No." := Rec."Entry No.";
        WVE.Description := TextString;

        WVE."Wage Posting Group" := PostingGroup;

        WVE."Wage Ledger Entry No." := WLE."Entry No.";
        WVE."User ID" := USERID;
        WVE."Global Dimension 1 Code" := WLE."Global Dimension 1 Code";
        WVE."Global Dimension 2 Code" := WLE."Global Dimension 2 Code";
        WVE."Shortcut Dimension 4 Code" := WLE."Shortcut Dimension 4 Code";
        WVE."Cost Amount (Actual)" := Amount;
        WVE."Document Date" := Rec."Date Of Calculation";
        WVE."Posting Date" := WLE."Posting Date";
        WVE."Entry Type" := EntryType;
        WVE."Contribution Type" := "Contribution Code";
        IF ATax.GET("Contribution Code") THEN BEGIN
            IF ATax."From Brutto" THEN
                WVE."AT From" := TRUE;
            IF ATax."Over Brutto" THEN
                WVE."AT From" := FALSE;
            IF ATax."Over Netto" THEN BEGIN
                WVE."AT From" := FALSE;
                WVE."AT From neto" := TRUE;
            END;
        END
        ELSE
            WVE."AT From" := FALSE;
        WVE."Post Code" := Employee."Post Code";
        IF WVE."Entry Type" = WVE."Entry Type"::Reduction THEN BEGIN
            WVE."Reduction No." := RedTemp."Reduction No.";
            WVE."Reduction Type" := RedTemp.Type;
        END;

        IF WVE."Entry Type" = WVE."Entry Type"::Untaxable THEN
            WVE."Wage Addition Type" := WageAddition."Wage Addition Type";

        IF WVE."Entry Type" = WVE."Entry Type"::Taxable THEN
            WVE."Wage Addition Type" := WageAdditionTaxable."Wage Addition Type";

        WVE.Basis := Basis;
        WVE."Contracted Work" := WLE."Contracted Work";

        WVE.INSERT;
        EntriesExist := TRUE;
    end;

    procedure POrdersInitValue(var WHeader: Record "Wage Header"; aWithConfirm: Boolean)
    var
        pOrder: Record "Payment Order";
    begin
        WithConfirm := aWithConfirm;
        CompInfo.GET;
        IF NOT (WHeader."Payment Orders printed") THEN BEGIN
            IF CompInfo."Entity Code" <> 'RS' THEN BEGIN
                PlatePoBankama(WHeader);
                Doprinosi(WHeader);
                DoprinosiBD(WHeader);
                DoprinosiFBIHRS(WHeader);
                Porezi(WHeader);
                IF M.FINDFIRST THEN
                    REPEAT
                        Department.RESET;
                        //Department.SETFILTER(Amount,'<>%1',0);
                        IF Department.FINDFIRST THEN
                            REPEAT
                            /*  Department.Amount:=0;
                              Department.AmountHealth:=0;
                              Department.AmountTax:=0;
                              Department.MODIFY;*/
                            UNTIL Department.NEXT = 0;
                    //DoprinosiP(WHeader, M);
                    //NKPoreziP(WHeader, M);
                    UNTIL M.NEXT = 0;
                //NK PlatePoBankamaPoslovnice(WHeader);
                //NK DoprinosiPoslovnice(WHeader);
                //PoreziBD(WHeader);
                Obustave(WHeader);

            END
            ELSE BEGIN
                PlatePoBankamaRS(WHeader);
                DoprinosiRS(WHeader);
                PoreziRS(WHeader);
                Obustave(WHeader);
            END;

            IF WHeader."Calc. Chamber Fee" THEN TrgovinskaKomora(WHeader);

            WHeader."Payment Orders printed" := TRUE;
            WHeader.MODIFY;
            MESSAGE(Txt0061);
            IF NOT WithConfirm THEN BEGIN
                pOrder.RESET;
                pOrder.SETRANGE("Wage Header No.", WHeader."No.");
                pOrder.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
                IF pOrder.FINDFIRST THEN BEGIN
                    COMMIT;
                    PAGE.RUNMODAL(PAGE::"Payment Orders", pOrder);
                END;
            END;
        END
        ELSE BEGIN
            ERROR(Txt015);
        END

    end;

    procedure MakePaymentOrder()
    var
        PayOrderNo: Integer;
        pOrder: Record "Payment Order";
    begin
        pOrder.InitPaymentOrder;
        i += 1;
        pOrder.InsertPaymentOrderValues1(
        SvrhaDoznake1,
        SvrhaDoznake2,
        SvrhaDoznake3,
        Primalac1,
        Primalac2,
        Primalac3,
        RacunPosiljaoca,
        RacunPrimaoca,
        Iznos, Contribution,
        Tip,
        Sifra,
        WType);

        pOrder.InsertPaymentOrderValues2(
        BrojPoreznogObaveznika,
        VrstaPrihoda,
        Opstina,
        PozivNaBroj,
        PorezniPeriodOd,
        PorezniPeriodDo,
        WHeaderNo,
        WHeaderEntryNo,
        WPaymentType,
        Contribution,
        Tip,
        Sifra,
        WType);
        PayOrderNo := pOrder.InsertPaymentOrder;
        COMMIT;
        pOrder.GET(PayOrderNo);
        IF WithConfirm THEN PAGE.RUNMODAL(PAGE::"Payment Order", pOrder);
    end;

    procedure InitPaymentOrder()
    begin
        CLEAR(SvrhaDoznake1);
        CLEAR(SvrhaDoznake2);
        CLEAR(SvrhaDoznake3);
        CLEAR(Primalac1);
        CLEAR(Primalac2);
        CLEAR(Primalac3);
        CLEAR(RacunPosiljaoca);
        CLEAR(RacunPrimaoca);
        CLEAR(Iznos);
        CLEAR(BrojPoreznogObaveznika);
        CLEAR(VrstaPrihoda);
        CLEAR(Opstina);
        CLEAR(PozivNaBroj);
        CLEAR(PorezniPeriodOd);
        CLEAR(PorezniPeriodDo);
        CLEAR(WHeaderNo);
        CLEAR(WHeaderEntryNo);
        CLEAR(WPaymentType);
        CLEAR(Contribution);
        CLEAR(WType);
    end;

    procedure PlatePoBankama(var WHeader: Record "Wage Header")
    var
        RBanks: Record "Wage/Reduction Bank";
        RBankAccounts: Record "Wage/Reduction Bank Accounts";
        Emp: Record "Employee";
        WC: Record "Wage Calculation";
        AmountForPayment: Decimal;
        AdditionAmountForPayment: Decimal;
        Single: Boolean;
        Counter: Integer;
        SingleEmp: Record "Employee";
    begin


        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        Emp.SETCURRENTKEY("Bank No.", "Bank Account Code");
        WC.SETCURRENTKEY("Wage Header No.", "Employee No.");
        WC.SETRANGE("Wage Header No.", WHeader."No.");
        WC.SETRANGE("Wage Calculation Type", 0);
        //WC.SETRANGE("Entry No.",WHeader."Entry No.");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Wage);
        //NKPOrders.DELETEALL;
        IF RBanks.FINDFIRST THEN
            REPEAT
                Emp.SETRANGE("Bank Account Code");
                Emp.SETRANGE("Bank No.", RBanks.Code);
                IF Emp.FINDFIRST THEN BEGIN
                    RBankAccounts.SETRANGE("Bank Code", RBanks.Code);
                    IF RBankAccounts.FINDFIRST THEN
                        REPEAT
                            Single := TRUE;
                            Counter := 0;

                            Emp.SETRANGE("Bank Account Code", FORMAT(RBankAccounts."No."));
                            AmountForPayment := 0;
                            AdditionAmountForPayment := 0;
                            AdditionAmountForPaymentMeal := 0;
                            RegresAmount := 0;
                            WageAdditionAmount := 0;
                            CLEAR(SingleEmp);
                            IF Emp.FINDFIRST THEN
                                REPEAT
                                    WC.SETRANGE("Employee No.", Emp."No.");
                                    IF WC.FINDFIRST THEN
                                        REPEAT
                                            Counter += 1;

                                            IF Counter = 1 THEN
                                                SingleEmp.GET(Emp."No.")
                                            ELSE
                                                IF Emp."No." <> SingleEmp."No." THEN Single := FALSE;
                                            /*  IF ((WC."Contribution Category Code"='FBIHRS') OR (WC."Contribution Category Code"='BDPIORS')) THEN

                                              AmountForPayment += WC."Tax Basis (RS)"-WC."Tax (RS)"-WC."Wage Reduction"
                                              ELSE*/
                                            WC.CALCFIELDS("Regres Netto Separate", "Regres Netto With Wage", "Use Netto");
                                            IF ((WC."Contribution Category Code" = 'BDPIOFBIH') OR (WC."Contribution Category Code" = 'BDPIORS'))
                                            THEN
                                                AmountForPayment += WC."Net Wage After Tax" - WC."Wage Reduction" - WC."Regres Netto Separate" - WC."Use Netto"
                                            ELSE
                                                AmountForPayment += WC."Net Wage After Tax" - WC."Wage Reduction" - WC."Use Netto";
                                            IF ((WC."Contribution Category Code" <> 'BDPIOFBIH') AND (WC."Contribution Category Code" <> 'BDPIORS')) THEN BEGIN
                                                AdditionAmountForPayment += WC.Transport;
                                                AdditionAmountForPaymentMeal += WC."Meal to pay";
                                            END
                                            ELSE BEGIN
                                                AdditionAmountForPayment := 0;
                                                AdditionAmountForPaymentMeal := 0;
                                            END;
                                            WC.CALCFIELDS("Regres Netto", "Regres Netto Separate");
                                            RegresAmount += (WC."Regres Netto" - WC."Regres Netto Separate");
                                            WC.CALCFIELDS("Meal Correction");
                                            WageAdditionAmount += WC."Meal Correction";
                                        UNTIL WC.NEXT = 0;
                                UNTIL Emp.NEXT = 0;
                            IF AmountForPayment > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                SvrhaDoznake1 := 'UPLATA PLAĆE';
                                //SvrhaDoznake1 :=Emp."No.";
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';
                                IF Single THEN
                                    SvrhaDoznake3 := SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := '';
                                //NK
                                SvrhaDoznake3 := Emp."No.";
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(CompInfo.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := RBankAccounts."Account No";
                                Iznos := ROUND(AmountForPayment, 0.01);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                Contribution := 'PLAĆA';
                                DatumUplate := WHeader."Payment Date";
                                MakePaymentOrder;

                            END;
                            IF AdditionAmountForPayment > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                SvrhaDoznake1 := 'UPLATA PREVOZA';
                                //SvrhaDoznake1 :=Emp."No.";
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';
                                IF Single THEN
                                    SvrhaDoznake3 := SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := Emp."No.";
                                SvrhaDoznake3 := Emp."No.";
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(CompInfo.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := RBankAccounts."Account No";
                                Iznos := ROUND(AdditionAmountForPayment, 0.01);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                Contribution := 'PREVOZ';
                                DatumUplate := WHeader."Payment Date";
                                MakePaymentOrder;
                            END;

                            IF AdditionAmountForPaymentMeal > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                SvrhaDoznake1 := 'UPLATA TOPLOG OBROKA';
                                // SvrhaDoznake1 :=Emp."No.";
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';
                                IF Single THEN
                                    SvrhaDoznake3 := SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := Emp."No.";
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(CompInfo.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := RBankAccounts."Account No";
                                Iznos := ROUND(AdditionAmountForPaymentMeal, 0.01);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                Contribution := 'TOPLI OBROK';
                                DatumUplate := WHeader."Payment Date";
                                MakePaymentOrder;
                            END;

                            IF RegresAmount > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                SvrhaDoznake1 := 'UPLATA REGRESA';
                                //SvrhaDoznake1 :=Emp."No.";
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';
                                IF Single THEN
                                    SvrhaDoznake3 := SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := '';
                                SvrhaDoznake3 := Emp."No.";
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(CompInfo.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := RBankAccounts."Account No";
                                Iznos := ROUND(RegresAmount, 0.01);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                Contribution := 'REGRES';
                                DatumUplate := WHeader."Payment Date";
                                MakePaymentOrder;
                            END;

                            IF WageAdditionAmount > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                SvrhaDoznake1 := 'UPLATA TOPLOG OBROKA';
                                //SvrhaDoznake1 :=Emp."No.";
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';
                                IF Single THEN
                                    SvrhaDoznake3 := SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := '';
                                SvrhaDoznake3 := Emp."No.";
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(CompInfo.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := RBankAccounts."Account No";
                                Iznos := ROUND(WageAdditionAmount, 0.01);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                Contribution := 'TOPLI OBROK';
                                DatumUplate := WHeader."Payment Date";
                                MakePaymentOrder;
                            END;
                        UNTIL RBankAccounts.NEXT = 0;
                END;
            UNTIL RBanks.NEXT = 0;

    end;

    procedure PlatePoBankamaRS(var WHeader: Record "Wage Header")
    var
        RBanks: Record "Wage/Reduction Bank";
        RBankAccounts: Record "Wage/Reduction Bank Accounts";
        Emp: Record "Employee";
        WC: Record "Wage Calculation";
        AmountForPayment: Decimal;
        AdditionAmountForPayment: Decimal;
        MealForPayment: Decimal;
        TransportForPayment: Decimal;
        Single: Boolean;
        Counter: Integer;
        SingleEmp: Record "Employee";
    begin

        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        Emp.SETCURRENTKEY("Bank No.", "Bank Account Code");
        WC.SETCURRENTKEY("Wage Header No.", "Employee No.");
        WC.SETRANGE("Wage Header No.", WHeader."No.");
        WC.SETRANGE("Entry No.", WHeader."Entry No.");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Wage);
        //NK POrders.DELETEALL;
        IF RBanks.FIND('-') THEN
            REPEAT
                Emp.SETRANGE("Bank Account Code");
                Emp.SETRANGE("Bank No.", RBanks.Code);
                IF Emp.FIND('-') THEN BEGIN
                    RBankAccounts.SETRANGE("Bank Code", RBanks.Code);
                    IF RBankAccounts.FIND('-') THEN
                        REPEAT
                            Single := TRUE;
                            Counter := 0;

                            Emp.SETRANGE("Bank Account Code", FORMAT(RBankAccounts."No."));

                            AmountForPayment := 0;
                            MealForPayment := 0;
                            TransportForPayment := 0;
                            CLEAR(SingleEmp);
                            IF Emp.FIND('-') THEN
                                REPEAT
                                    WC.SETRANGE("Employee No.", Emp."No.");
                                    IF WC.FIND('-') THEN
                                        REPEAT
                                            Counter += 1;

                                            IF Counter = 1 THEN
                                                SingleEmp.GET(Emp."No.")
                                            ELSE
                                                IF Emp."No." <> SingleEmp."No." THEN Single := FALSE;

                                            AmountForPayment += WC."Net Wage After Tax" - WC."Wage Reduction";
                                            AdditionAmountForPayment += WC."Untaxable Wage";
                                            MealForPayment += WC."Meal to pay";
                                            TransportForPayment += WC.Transport;
                                        UNTIL WC.NEXT = 0;
                                UNTIL Emp.NEXT = 0;
                            IF AmountForPayment > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                SvrhaDoznake1 := 'UPLATA PLAĺE';
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';
                                IF Single THEN
                                    SvrhaDoznake3 := 'BR Tekuceg: ' + SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := '';
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(RBanks.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := FORMAT(RBankAccounts."Account No");
                                Iznos := ROUND(AmountForPayment, 0.01);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                DatumUplate := WHeader."Payment Date";
                                MakePaymentOrder;
                            END;

                            IF ((MealForPayment > 0) AND (CompInfo."Entity Code" <> 'RS')) THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                SvrhaDoznake1 := 'UPLATA TOPL.OBROK';
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';
                                IF Single THEN
                                    SvrhaDoznake3 := 'BR Tekuceg: ' + SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := '';

                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(RBanks.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := FORMAT(RBankAccounts."Account No");
                                Iznos := ROUND(MealForPayment, 0.01);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                DatumUplate := WHeader."Payment Date";
                                MakePaymentOrder;
                            END;

                            IF TransportForPayment > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                SvrhaDoznake1 := 'UPLATA PREVOZ';
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';
                                IF Single THEN
                                    SvrhaDoznake3 := 'BR Tekuceg: ' + SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := '';

                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(RBanks.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := FORMAT(RBankAccounts."Account No");
                                Iznos := ROUND(TransportForPayment, 0.01);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                DatumUplate := WHeader."Payment Date";
                                MakePaymentOrder;
                            END;


                            IF AdditionAmountForPayment > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                SvrhaDoznake1 := 'UPLATA PLAĺE - dodaci';
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';
                                IF Single THEN
                                    SvrhaDoznake3 := 'BR Tekuceg: ' + SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := '';

                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(RBanks.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := FORMAT(RBankAccounts."Account No");
                                Iznos := ROUND(AdditionAmountForPayment, 0.01);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                DatumUplate := WHeader."Payment Date";
                                MakePaymentOrder;
                            END;

                        UNTIL RBankAccounts.NEXT = 0;
                END;
            UNTIL RBanks.NEXT = 0;
    end;

    procedure Doprinosi(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record Municipality;
        MunicipalityTemp: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        //Nezaposleni
        WageSetup.GET;
        WageSetup.TESTFIELD("Unemployment Federation");
        WageSetup.TESTFIELD("Unemployment Canton");
        PKan := WageSetup."Unemployment Canton";
        PFed := WageSetup."Unemployment Federation";



        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Unemployment);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE.SETRANGE("Contribution Category Code", 'FBIH');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        //Municipality.FINDFIRST;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //  Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");
                                //  CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                //  CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //CantonTemp."For Calculation" += ROUND(TempAmount*PKan/100,0.01);
                            MunicipalityTemp."For Calculation" += ROUND(TempAmount * PKan / 100, 0.01);
                            //  CantonTemp.MODIFY;
                            MunicipalityTemp.MODIFY;
                            FAmount += ROUND(TempAmount * PFed / 100, 0.01);
                            KAmount += ROUND(TempAmount * PKan / 100, 0.01);
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;
            Tip := 0;
            Sifra := 'FBIH';
            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za nezaposlenost';
            WType := 0;

            /*PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        IF KAmount > 0 THEN BEGIN
            //IF CantonTemp.FINDFIRST THEN REPEAT
            IF MunicipalityTemp.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    // AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                    AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);

                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := 'Opština ' + MunicipalityTemp.Name;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.01);
                    Iznos := ROUND(MunicipalityTemp."For Calculation", 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za nezaposlenost';
                    Tip := 1;
                    Sifra := COPYSTR(FORMAT(MunicipalityTemp."DP Code"), 1, 4);
                    WType := 0;
                    /*PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                //UNTIL CantonTemp.NEXT = 0;
                UNTIL MunicipalityTemp.NEXT = 0;
        END;

        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        //Zdravstvo
        PKan := WageSetup."Health Canton";
        PFed := WageSetup."Health Federation";

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'FBIH');
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        //NK2  AddTaxPE.SETRANGE("Wage Calculation Type",0);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            MunicipalityTemp."For Calculation 2" += ROUND(TempAmount * PKan / 100, 0.01);
                            MunicipalityTemp.MODIFY;

                            FAmount += ROUND(TempAmount * PFed / 100, 0.01);
                            KAmount += ROUND(TempAmount * PKan / 100, 0.01);
                            //  MESSAGE(FORMAT(KAmount));
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := AddTaxPE."Wage Calculation Type";
            Tip := 1;
            Sifra := AddTaxPS.Code;
            WType := 0;
            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';

            /* PozivNaBroj := '00000000';
             IF WHeader."Month Of Wage" < 10 THEN
              PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
             ELSE
              PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        IF KAmount > 0 THEN BEGIN
            //IF CantonTemp.FINDFIRST THEN REPEAT
            IF MunicipalityTemp.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    //AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);

                    // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                    AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.01);
                    Iznos := ROUND(MunicipalityTemp."For Calculation 2", 0.01);
                    Tip := 1;
                    Sifra := COPYSTR(FORMAT(MunicipalityTemp."DP Code"), 1, 4);
                    WType := 0;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';

                    /* PozivNaBroj := '00000000';
                     IF WHeader."Month Of Wage" < 10 THEN
                      PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                     ELSE
                      PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                //UNTIL CantonTemp.NEXT = 0;
                UNTIL MunicipalityTemp.NEXT = 0;
        END;

        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETFILTER("Contribution Category Code", '%1|%2|%3', 'FBIH', 'FBIHRS', 'BDPIOFBIH');
        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := AddTaxPS.Code;
            WType := 0;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        //Posebni porezi
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                        TempAmount := AddTaxPE."Amount Over Neto";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    AddTaxPS.FINDFIRST;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := 'FBIH';
                    WType := 0;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";

                    /*PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL AddTax.NEXT = 0;

        //Posebni porezi fond
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;


                AddTaxPE.SETRANGE("Employee No.", '');
                AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                TempAmount := AddTaxPE."Amount Over Neto";
                FAmount += TempAmount;

                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    AddTaxPS.FINDFIRST;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := 'FBIH';
                    WType := 0;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                    /*
                    PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL AddTax.NEXT = 0;

        //Posebni porezi komora
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Chamber);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;


                AddTaxPE.SETRANGE("Employee No.", '');
                AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                TempAmount := AddTaxPE."Amount Over Neto";
                FAmount += TempAmount;

                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Chamber);
                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    AddTaxPS.FINDFIRST;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := 'FBIH';
                    WType := 0;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                    /*
                    PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL AddTax.NEXT = 0;

    end;

    procedure DoprinosiRS(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        _______RS_________: Integer;
        RSAmount: Decimal;
        PIOAmount: Decimal;
        ZDRAmount: Decimal;
        DJZAmount: Decimal;
        NEZAmount: Decimal;
    begin

        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        //Nezaposleni
        PKan := 70;
        PFed := 30;



        Reduction.SETFILTER(Type, '%1', 'FONSOLRS');
        Reduction.SETRANGE("Wage Header No.", WHeader."No.");
        //Reduction.SETFILTER("Employee No.",'%1',Emp."No.");
        Reduction.SETCURRENTKEY("Wage Header No.", Type);
        Reduction.CALCSUMS(Amount);
        AmountOverRed += Reduction.Amount;


        // MESSAGE(FORMAT(AmountOverRed));
        // MESSAGE(FORMAT(Emp."No."));



        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::RS);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        //NK CantonTemp.DELETEALL;
        IF AddTax.FIND('-') THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FIND('-') THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage", "Amount Over Neto");
                        TempAmount := AddTaxPE."Amount From Wage";
                        TempAmountSpecTemp := AddTaxPE."Amount Over Neto";
                        AmountOverTemp := AddTaxPE."Amount Over Wage";



                        IF ((TempAmount > 0) OR (TempAmountSpecTemp > 0) OR (AmountOverTemp > 0)) THEN BEGIN
                            IF Emp."Entity Code" = 'RS' THEN BEGIN
                                RSAmount += TempAmount;

                                TempAmountSpec += TempAmountSpecTemp;
                                AmountOver += AmountOverTemp;

                            END;



                            IF Emp."Entity Code" = 'FBIH' THEN BEGIN
                                CASE AddTax.Code OF
                                    'DJEµ. ZA…T':
                                        DJZAmount += TempAmount;
                                    'D-PIORS':
                                        PIOAmount += TempAmount;

                                    'D-ZAPO…-RS':
                                        NEZAmount += TempAmount;
                                    'D-SOLID':
                                        SOLIDAmount += TempAmount;
                                    'D-ZDRAV-RS':
                                        BEGIN
                                            IF NOT CantonTemp.GET(Emp.County, Emp."Entity Code") THEN BEGIN
                                                Canton.GET(Emp.County, Emp."Entity Code");
                                                CantonTemp.INIT;
                                                CantonTemp.TRANSFERFIELDS(Canton, TRUE);
                                                CantonTemp.INSERT;
                                            END;
                                            CantonTemp."For Calculation" += TempAmount;
                                            CantonTemp.MODIFY;
                                        END;
                                END;
                            END;
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF RSAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIHRS');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);
            AddTaxPS.SETFILTER("Add. Tax Code", '%1', '');
            AddTaxPS.FIND('-');
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(RSAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            /*PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";

            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;


        IF AmountOver > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIHRS');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);

            AddTaxPS.SETFILTER("Add. Tax Code", '%1', 'D-INVALID');
            AddTaxPS.FIND('-');
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(AmountOver + AmountOverRed, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            /*PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;




        IF TempAmountSpec > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FIBHRS');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);
            AddTaxPS.SETFILTER("Add. Tax Code", '%1', 'D-SOLID');
            AddTaxPS.FIND('-');
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(TempAmountSpec, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            /*PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;




        IF PIOAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIHRS');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);
            AddTaxPS.SETFILTER("Add. Tax Code", '%1', 'D-PIORS');
            AddTaxPS.FIND('-');
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(PIOAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            /*PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        IF NEZAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIHRS');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);
            AddTaxPS.SETFILTER("Add. Tax Code", '%1', 'D-ZAPO…-RS');
            AddTaxPS.FIND('-');
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(NEZAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            /*PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;
        //SOLID


        IF SOLIDAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIHRS');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);
            AddTaxPS.SETRANGE("Add. Tax Code", '%1', 'D-SOLID');
            AddTaxPS.FIND('-');
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(SOLIDAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            /*PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;
        //END solid

        IF DJZAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIHRS');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::RS);
            AddTaxPS.SETRANGE("Add. Tax Code", '%1', 'DJEµ. ZA…T');
            AddTaxPS.FIND('-');
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(DJZAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            /*PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        IF CantonTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Canton);
                AddTaxPS.SETRANGE(Code, CantonTemp.Code);
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                AddTaxPS.FIND('-');

                InitPaymentOrder;

                SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                Primalac1 := AddTaxPS."Payment Receiver1";
                Primalac2 := AddTaxPS."Payment Receiver2";
                Primalac3 := CantonTemp.Description;
                RacunPosiljaoca := BankAccounts."Bank Account No.";
                RacunPrimaoca := AddTaxPS."Payment Account";
                BrojPoreznogObaveznika := CompInfo."Registration No.";
                VrstaPrihoda := AddTaxPS."Revenue Type";
                Opstina := CompInfo."Municipality Code";
                PorezniPeriodOd := StartDate;
                PorezniPeriodDo := EndDate;
                Sifra := AddTaxPS.Code;
                Iznos := ROUND(CantonTemp."For Calculation", 0.01);
                WHeaderNo := WHeader."No.";
                WHeaderEntryNo := WHeader."Entry No.";
                WPaymentType := WPaymentType::"Add. Tax";
                /*PozivNaBroj := '00000000';
                IF WHeader."Month Of Wage" < 10 THEN
                 PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                ELSE
                 PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                PozivNaBroj := AddTaxPS."Refer To Number";
                DatumUplate := WHeader."Payment Date";
                MakePaymentOrder;
            UNTIL CantonTemp.NEXT = 0;

    end;

    procedure Porezi(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //TaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //TaxPE.SETRANGE("Contribution Category Code",'FBIH');
        TaxPE.SETRANGE("Wage Calculation Type", 0);
        Mun.RESET;
        FAmount := 0;
        IF Mun.FINDFIRST THEN
            REPEAT
                TaxPE.SETRANGE("Tax Number", Mun."Tax Number");
                TaxPE.CALCSUMS(Amount);
                FAmount := TaxPE.Amount;
                IF TaxPE.FINDFIRST THEN BEGIN
                    IF TaxPE."Canton Code" = 'FBIHRS' THEN
                        Canton.GET(TaxPE."Canton Code", 'RS');
                    IF TaxPE."Canton Code" = 'FBIH' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
                        Canton.GET(TaxPE."Canton Code", 'BD');
                END;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    IF Mun."DP Code" <> 'REG1' THEN
                        AddTaxPS.SETRANGE(Code, Mun.Code)
                    ELSE BEGIN
                        CompInfo.GET;
                        AddTaxPS.SETRANGE(Code, CompInfo."Municipality Code");
                    END;
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                    AddTaxPS.FINDFIRST;

                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := 'Opština ' + Mun.Name;
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 2;
                    Sifra := AddTaxPS.Code;
                    WType := 0;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";

                    Opstina := Mun."Tax Number";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;

                    Iznos := ROUND(FAmount, 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Porez';

                    /* PozivNaBroj := '00000000';
                     IF WHeader."Month Of Wage" < 10 THEN
                      PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                     ELSE
                      PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL Mun.NEXT = 0;

    end;

    procedure PoreziRS(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
        NONRSAmount: Decimal;
        RSMun: Boolean;
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        TaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        Mun.RESET;
        FAmount := 0;
        NONRSAmount := 0;
        IF Mun.FINDFIRST THEN
            REPEAT
                RSMun := FALSE;
                TaxPE.SETRANGE("Tax Number", Mun."Tax Number");
                TaxPE.CALCSUMS(Amount);
                FAmount := TaxPE.Amount;
                IF TaxPE.FINDFIRST THEN BEGIN
                    IF TaxPE."Canton Code" = 'FBIHRS' THEN BEGIN
                        Canton.GET(TaxPE."Canton Code", 'RS');
                        RSMun := TRUE;
                    END
                    ELSE
                        NONRSAmount += FAmount;
                END;
                IF RSMun AND (FAmount > 0) THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    AddTaxPS.SETRANGE(Code, Mun.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                    AddTaxPS.FINDFIRST;

                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;

                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := Mun."Tax Number";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;

                    Iznos := ROUND(FAmount, 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    /*PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";

                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL Mun.NEXT = 0;

        IF (NONRSAmount > 0) THEN BEGIN
            Mun.GET('1' + CompInfo."Municipality Code");
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
            AddTaxPS.SETRANGE(Code, Mun.Code);
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
            AddTaxPS.FINDFIRST;

            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3" + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := '';

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := Mun."Tax Number";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(NONRSAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            /*PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

    end;

    procedure Obustave(var WHeader: Record "Wage Header")
    var
        Reductions: Record "Reduction";
        RTypes: Record "Reduction Types";
        RBanks: Record "Wage/Reduction Bank";
        RBankAccounts: Record "Wage/Reduction Bank Accounts";
        WageSetup: Record "Wage Setup";
        Amount: Decimal;
        IsSingle: Boolean;
        RPW: Record "Reduction per Wage";
        IsFirst: Boolean;
        Emp: Record "Employee";
        FirstReduction: Record "Reduction";
        SinglePaymentOrder: Boolean;
    begin
        RPW.SETCURRENTKEY("Reduction No.", "Wage Header No.", Locked);
        RPW.SETRANGE("Wage Header No.", WHeader."No.");
        RPW.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Reduction);
        //NK POrders.DELETEALL;

        IF RBanks.FINDFIRST THEN
            REPEAT
                RBankAccounts.SETRANGE("Bank Code", RBanks.Code);
                IF RBankAccounts.FINDFIRST THEN
                    REPEAT
                        Reductions.SETRANGE(BankAccountCode, RBanks.Code);
                        // IF EVALUATE(BankNo,RBankAccounts."No.") THEN
                        Reductions.SETRANGE(BankAccountCodeNo, RBankAccounts."No.");
                        IF RTypes.FINDFIRST THEN
                            REPEAT
                                SinglePaymentOrder := RTypes."Separate Payment";
                                Reductions.SETRANGE(Type, RTypes.Code);

                                IF SinglePaymentOrder THEN BEGIN
                                    IF Reductions.FINDFIRST THEN
                                        REPEAT
                                            Amount := 0;
                                            RPW.SETRANGE("Reduction No.", Reductions."No.");
                                            IF RPW.FINDFIRST THEN
                                                REPEAT
                                                    Amount += RPW.Amount;
                                                UNTIL RPW.NEXT = 0;
                                            IF Amount > 0 THEN BEGIN
                                                InitPaymentOrder;

                                                IF Reductions.Type = 'KREDIT' THEN
                                                    SvrhaDoznake1 := Reductions."Party No." + ' Uplata rate kredita'
                                                ELSE
                                                    IF Reductions.Type = 'DONAC.' THEN
                                                        SvrhaDoznake1 := 'Uplata donacije'
                                                    ELSE
                                                        SvrhaDoznake1 := Reductions."Party No." + ' Uplata';

                                                Emp.GET(Reductions."Employee No.");
                                                SvrhaDoznake2 := '';
                                                IF Reductions.ContractNo <> '' THEN
                                                    SvrhaDoznake3 := Reductions.ContractNo
                                                ELSE
                                                    SvrhaDoznake3 := RTypes.Description + ' ' + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';

                                                Primalac1 := '';
                                                Primalac2 := RBanks.Name;
                                                Primalac3 := '';

                                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                                RacunPrimaoca := FORMAT(RBankAccounts."Account No");
                                                Contribution := 'Obustava';
                                                Iznos := ROUND(Amount, 0.01);
                                                WHeaderNo := WHeader."No.";
                                                WHeaderEntryNo := WHeader."Entry No.";
                                                WPaymentType := WPaymentType::Reduction;
                                                DatumUplate := WHeader."Payment Date";
                                                MakePaymentOrder;
                                            END;
                                        UNTIL Reductions.NEXT = 0;
                                END
                                ELSE BEGIN

                                    IsFirst := TRUE;
                                    IsSingle := TRUE;
                                    Amount := 0;
                                    IF Reductions.FINDFIRST THEN
                                        REPEAT
                                            RPW.SETRANGE("Reduction No.", Reductions."No.");
                                            IF RPW.FINDFIRST THEN
                                                REPEAT
                                                    IF IsFirst THEN
                                                        FirstReduction.GET(Reductions."No.");
                                                    IF NOT IsFirst THEN
                                                        IsSingle := FALSE;
                                                    IsFirst := FALSE;
                                                    Amount += RPW.Amount;
                                                UNTIL RPW.NEXT = 0;
                                        UNTIL Reductions.NEXT = 0;
                                    IF Amount > 0 THEN BEGIN
                                        InitPaymentOrder;

                                        IF Reductions.Type = 'KREDIT' THEN
                                            SvrhaDoznake1 := 'Uplata rate kredita'
                                        ELSE
                                            IF Reductions.Type = 'DONAC.' THEN
                                                SvrhaDoznake1 := 'Uplata donacije'
                                            ELSE
                                                SvrhaDoznake1 := 'Uplata';

                                        IF NOT IsSingle THEN BEGIN
                                            SvrhaDoznake2 := RBanks.Name;
                                            SvrhaDoznake3 := RTypes.Description;
                                        END
                                        ELSE BEGIN
                                            Emp.GET(FirstReduction."Employee No.");
                                            SvrhaDoznake2 := '';
                                            IF Reductions.ContractNo <> '' THEN
                                                SvrhaDoznake3 := FirstReduction.ContractNo
                                            ELSE
                                                SvrhaDoznake3 := RTypes.Description + ' ' + FORMAT(WHeader."Month Of Wage") + '. ' + FORMAT(WHeader."Year Of Wage") + '.';
                                        END;

                                        Primalac1 := '';
                                        Primalac2 := RBanks.Name;
                                        Primalac3 := '';

                                        RacunPosiljaoca := BankAccounts."Bank Account No.";
                                        RacunPrimaoca := FORMAT(RBankAccounts."Account No");
                                        Contribution := 'Obustava';
                                        Iznos := ROUND(Amount, 0.01);
                                        WHeaderNo := WHeader."No.";
                                        WHeaderEntryNo := WHeader."Entry No.";
                                        WPaymentType := WPaymentType::Reduction;
                                        DatumUplate := WHeader."Payment Date";
                                        MakePaymentOrder;
                                    END;
                                END;
                            UNTIL RTypes.NEXT = 0;
                    UNTIL RBankAccounts.NEXT = 0;
            UNTIL RBanks.NEXT = 0;

        WageSetup.GET;
    end;

    procedure TrgovinskaKomora(var WHeader: Record "Wage Header")
    var
        WageSetup: Record "Wage Setup";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        WageSetup.GET;
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Chamber);
        //NK POrders.DELETEALL;
    end;

    procedure DoprinosiTC(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);
        //Zdravstvo
        //PKan :=89.8;
        //PFed := 10.2;

        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        PKan := WageSetup."Health Canton";
        PFed := WageSetup."Health Federation";

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        FAmount := 0;
        KAmount := 0;


        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 1);
        AddTaxPE.SETRANGE(Calculated, FALSE);
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.SETRANGE("Wage Calculation Type", 1);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";

                        FAmount += ROUND(TempAmount * PFed / 100, 0.01);
                        KAmount += ROUND(TempAmount * PKan / 100, 0.01);
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            MunicipalityTemp."For Calculation 2" += ROUND(TempAmount * (PKan) / 100, 0.01);
                            MunicipalityTemp.MODIFY;

                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            IF AddTaxPS.FINDFIRST THEN;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := 1;
            Tip := 1;
            Sifra := AddTaxPS.Code;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        //IF CantonTemp.FINDFIRST THEN REPEAT
        IF MunicipalityTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                //AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);

                // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                IF AddTaxPS.FINDFIRST THEN;
                IF MunicipalityTemp."For Calculation 2" > 0 THEN BEGIN
                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.01);
                    Iznos := ROUND(MunicipalityTemp."For Calculation 2", 0.01);
                    Tip := 1;
                    Sifra := COPYSTR(FORMAT(MunicipalityTemp."DP Code"), 1, 4);
                    WType := 1;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';

                    /*PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;

                END;
            //UNTIL CantonTemp.NEXT = 0;
            UNTIL MunicipalityTemp.NEXT = 0;


        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 1);
        AddTaxPE.SETRANGE(Calculated, FALSE);
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";

                        FAmount += TempAmount;

                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
            IF AddTaxPS.FINDFIRST THEN;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := AddTaxPS.Code;
            WType := 1;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        //Posebni porezi
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 1);
        AddTaxPE.SETRANGE(Calculated, FALSE);
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                        TempAmount := AddTaxPE."Amount Over Neto" + AddTaxPE."Amount Over Wage";
                        FAmount += TempAmount;

                    UNTIL Emp.NEXT = 0;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    IF AddTaxPS.FINDFIRST THEN;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := 'FBIH';
                    WType := 1;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                    /*
                      PozivNaBroj := '00000000';
                      IF WHeader."Month Of Wage" < 10 THEN
                       PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                      ELSE
                       PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;


                END;



            UNTIL AddTax.NEXT = 0;

    end;

    procedure PoreziTC(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        TaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        TaxPE.SETFILTER("Wage Calculation Type", '%1', 1);
        TaxPE.SETRANGE(Calculated, FALSE);
        Mun.RESET;
        FAmount := 0;
        IF Mun.FINDFIRST THEN
            REPEAT
                TaxPE.SETRANGE("Tax Number", Mun."Tax Number");
                TaxPE.SETFILTER("Wage Calculation Type", '%1', 1);
                ;
                TaxPE.CALCSUMS(Amount);
                FAmount := TaxPE.Amount;
                IF TaxPE.FINDFIRST THEN BEGIN
                    IF TaxPE."Canton Code" = 'FBIHRS' THEN
                        Canton.GET(TaxPE."Canton Code", 'RS');
                    IF TaxPE."Canton Code" = 'FBIH' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
                        Canton.GET(TaxPE."Canton Code", 'BD');
                END;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    IF Mun."DP Code" <> 'REG1' THEN
                        AddTaxPS.SETRANGE(Code, Mun.Code)
                    ELSE BEGIN
                        CompInfo.GET;
                        AddTaxPS.SETRANGE(Code, CompInfo."Municipality Code");
                    END;
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                    AddTaxPS.FINDFIRST;

                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := 'Opština ' + Mun.Name;
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 1;
                    Sifra := AddTaxPS.Code;
                    WType := 1;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := Mun."Tax Number";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;

                    Iznos := ROUND(FAmount, 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Porez';
                    /*
                    PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                    TaxPE.Calculated := TRUE;
                    TaxPE.MODIFY;
                END;
            UNTIL Mun.NEXT = 0;

    end;

    procedure DoprinosiTCNR(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);
        //Zdravstvo
        //PKan :=89.8;
        //PFed := 10.2;
        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        PKan := WageSetup."Health Canton";
        PFed := WageSetup."Health Federation";

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        FAmount := 0;
        KAmount := 0;


        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 2);
        AddTaxPE.SETRANGE(Calculated, FALSE);

        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.SETRANGE("Wage Calculation Type", 2);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        WageSetup.GET;
                        FAmount += ROUND(TempAmount * PFed / 100, 0.01);
                        KAmount += ROUND(TempAmount * PKan / 100, 0.01);
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            MunicipalityTemp."For Calculation 2" += ROUND(TempAmount * (PKan) / 100, 0.01);
                            MunicipalityTemp.MODIFY;

                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            IF AddTaxPS.FINDFIRST THEN;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := 2;
            Tip := 1;
            Sifra := AddTaxPS.Code;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            /*
             PozivNaBroj := '00000000';
             IF WHeader."Month Of Wage" < 10 THEN
              PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
             ELSE
              PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";

            MakePaymentOrder;
        END;

        //IF CantonTemp.FINDFIRST THEN REPEAT
        IF MunicipalityTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                //AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);

                // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                IF AddTaxPS.FINDFIRST THEN;

                IF KAmount > 0 THEN BEGIN
                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := (MunicipalityTemp.Code);
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.01);
                    Iznos := ROUND(MunicipalityTemp."For Calculation 2", 0.01);
                    Tip := 1;
                    Sifra := COPYSTR(FORMAT(MunicipalityTemp."DP Code"), 1, 4);
                    WType := 2;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';

                    /* PozivNaBroj := '00000000';
                     IF WHeader."Month Of Wage" < 10 THEN
                      PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                     ELSE
                      PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                    //UNTIL CantonTemp.NEXT = 0;
                END;
            UNTIL MunicipalityTemp.NEXT = 0;


        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 2);
        AddTaxPE.SETRANGE(Calculated, FALSE);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
            IF AddTaxPS.FINDFIRST THEN;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := AddTaxPS.Code;
            WType := 2;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';

            /*PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        //Posebni porezi
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 2);
        AddTaxPE.SETRANGE(Calculated, FALSE);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                        TempAmount := AddTaxPE."Amount Over Neto" + AddTaxPE."Amount Over Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    IF AddTaxPS.FINDFIRST THEN;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := 'FBIH';
                    WType := 2;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                    /*
                      PozivNaBroj := '00000000';
                      IF WHeader."Month Of Wage" < 10 THEN
                       PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                      ELSE
                       PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL AddTax.NEXT = 0;

    end;

    procedure DoprinosiTCAC(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);
        //Zdravstvo
        //PKan :=89.8;
        //PFed := 10.2;


        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        PKan := WageSetup."Health Canton";
        PFed := WageSetup."Health Federation";

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        FAmount := 0;
        KAmount := 0;


        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 3);
        AddTaxPE.SETRANGE(Calculated, FALSE);

        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.SETRANGE("Wage Calculation Type", 3);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += ROUND(TempAmount * PFed / 100, 0.01);
                        KAmount += ROUND(TempAmount * PKan / 100, 0.01);
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            MunicipalityTemp."For Calculation 2" += ROUND(TempAmount * (PKan) / 100, 0.01);
                            MunicipalityTemp.MODIFY;

                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            IF AddTaxPS.FINDFIRST THEN;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := 3;
            Tip := 1;
            Sifra := AddTaxPS.Code;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';

            /*PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;


        //IF CantonTemp.FINDFIRST THEN REPEAT
        IF MunicipalityTemp.FIND('-') THEN
            REPEAT
                AddTaxPS.RESET;
                //AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);

                // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                IF AddTaxPS.FINDFIRST THEN;
                IF KAmount > 0 THEN BEGIN
                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.01);
                    Iznos := ROUND(MunicipalityTemp."For Calculation 2", 0.01);
                    Tip := 1;
                    Sifra := COPYSTR(FORMAT(MunicipalityTemp."DP Code"), 1, 4);
                    WType := 3;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';
                    /*
                    PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            //UNTIL CantonTemp.NEXT = 0;
            UNTIL MunicipalityTemp.NEXT = 0;


        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 3);
        AddTaxPE.SETRANGE(Calculated, FALSE);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
            IF AddTaxPS.FINDFIRST THEN;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := AddTaxPS.Code;
            WType := 3;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';
            /*
             PozivNaBroj := '00000000';
             IF WHeader."Month Of Wage" < 10 THEN
              PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
             ELSE
              PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        //Posebni porezi
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.", Calculated);
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 3);
        AddTaxPE.SETRANGE(Calculated, FALSE);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                        TempAmount := AddTaxPE."Amount Over Neto" + AddTaxPE."Amount Over Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    IF AddTaxPS.FINDFIRST THEN;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := 'FBIH';
                    WType := 3;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                    /*
                      PozivNaBroj := '00000000';
                      IF WHeader."Month Of Wage" < 10 THEN
                       PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                      ELSE
                       PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL AddTax.NEXT = 0;

    end;

    procedure PoreziTCNR(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        TaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        TaxPE.SETRANGE("Wage Calculation Type", 2);
        TaxPE.SETRANGE(Calculated, FALSE);
        Mun.RESET;
        FAmount := 0;
        IF Mun.FINDFIRST THEN
            REPEAT
                TaxPE.SETRANGE("Tax Number", Mun."Tax Number");
                TaxPE.SETRANGE("Wage Calculation Type", 2);

                TaxPE.CALCSUMS(Amount);
                FAmount := TaxPE.Amount;
                IF TaxPE.FINDFIRST THEN BEGIN
                    IF TaxPE."Canton Code" = 'FBIHRS' THEN
                        Canton.GET(TaxPE."Canton Code", 'RS');
                    IF TaxPE."Canton Code" = 'FBIH' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
                        Canton.GET(TaxPE."Canton Code", 'BD');
                END;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    AddTaxPS.SETRANGE(Code, Mun.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := 'Opština ' + Mun.Name;
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 2;
                    Sifra := AddTaxPS.Code;
                    WType := 2;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := Mun."Tax Number";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;

                    Iznos := ROUND(FAmount, 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Porez';
                    /*
                    PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                    TaxPE.Calculated := TRUE;
                    TaxPE.MODIFY;
                END;
            UNTIL Mun.NEXT = 0;

    end;

    procedure PoreziTCAC(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        TaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        TaxPE.SETRANGE("Wage Calculation Type", 3);
        TaxPE.SETRANGE(Calculated, FALSE);
        Mun.RESET;
        FAmount := 0;
        IF Mun.FINDFIRST THEN
            REPEAT
                TaxPE.SETRANGE("Tax Number", Mun."Tax Number");
                TaxPE.SETRANGE("Wage Calculation Type", 3);

                TaxPE.CALCSUMS(Amount);
                FAmount := TaxPE.Amount;
                IF TaxPE.FINDFIRST THEN BEGIN
                    IF TaxPE."Canton Code" = 'FBIHRS' THEN
                        Canton.GET(TaxPE."Canton Code", 'RS');
                    IF TaxPE."Canton Code" = 'FBIH' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
                        Canton.GET(TaxPE."Canton Code", 'BD');
                END;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    AddTaxPS.SETRANGE(Code, Mun.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := 'Opština ' + Mun.Name;
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 2;
                    Sifra := AddTaxPS.Code;
                    WType := 3;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := Mun."Tax Number";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;

                    Iznos := ROUND(FAmount, 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Porez';
                    /*
                      PozivNaBroj := '00000000';
                      IF WHeader."Month Of Wage" < 10 THEN
                       PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                      ELSE
                       PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                    TaxPE.Calculated := TRUE;
                    TaxPE.MODIFY;
                END;
            UNTIL Mun.NEXT = 0;

    end;

    procedure DoprinosiBD(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        //Nezaposleni
        WageSetup.GET;

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Unemployment);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1|%2', 'BDPIOFBIH', 'BDPIORS');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        //Municipality.FINDFIRST;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //  Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");
                                //  CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                //  CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //CantonTemp."For Calculation" += ROUND(TempAmount*PKan/100,0.01);
                            MunicipalityTemp."For Calculation" += ROUND(TempAmount, 0.01);
                            //  CantonTemp.MODIFY;
                            MunicipalityTemp.MODIFY;
                            FAmount += ROUND(TempAmount, 0.01);

                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'BD');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            //BD NK Opstina := CompInfo."Municipality Code";
            Opstina := MunicipalityTemp.Code;
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;
            Tip := 0;
            Sifra := 'BD';
            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za nezaposlenost';
            WType := 0;
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;



        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        //Zdravstvo

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETFILTER("Contribution Category Code", '%1|%2', 'BDPIOFBIH', 'BDPIORS');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            //NK MunicipalityTemp."For Calculation 2" += ROUND(TempAmount*PKan/100,0.01);
                            //NK MunicipalityTemp.MODIFY;

                            FAmount += ROUND(TempAmount, 0.01);

                            //  MESSAGE(FORMAT(KAmount));
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'BD');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := 0;
            Tip := 1;
            Sifra := AddTaxPS.Code;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            //NK BD Opstina := CompInfo."Municipality Code";
            Opstina := MunicipalityTemp.Code;
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        /*
        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type,AddTax.Type::PIO);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.","Entry No.",
                               "Contribution Code","Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.",WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
          AddTaxPE.SETRANGE("Wage Calculation Type",0);
        AddTaxPE.SETFILTER("Contribution Category Code",'%1|2','BDPIOFBIH','BDPIORS');
        
        IF AddTax.FINDFIRST THEN REPEAT
         AddTaxPE.SETRANGE("Contribution Code",AddTax.Code);
         Emp.RESET;
         IF Emp.FINDFIRST THEN REPEAT
          AddTaxPE.SETRANGE("Employee No.",Emp."No.");
          AddTaxPE.CALCSUMS("Amount Over Wage","Amount From Wage");
          TempAmount := AddTaxPE."Amount Over Wage"+AddTaxPE."Amount From Wage";
          FAmount += TempAmount;
         UNTIL Emp.NEXT = 0;
        UNTIL AddTax.NEXT = 0;
        
        IF FAmount > 0 THEN BEGIN
         AddTaxPS.RESET;
         AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
         AddTaxPS.SETRANGE(Code,'BD');
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::PIO);
         AddTaxPS.FINDFIRST;
         InitPaymentOrder;
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := AddTaxPS."Payment Receiver3";
         Tip:=1;
         Sifra:=AddTaxPS.Code;
          WType:=AddTaxPE."Wage Calculation Type";
        
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := CompInfo."Registration No.";
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := CompInfo."Municipality Code";
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
        
         Iznos := ROUND(FAmount,0.01);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
         Contribution:='Doprinosi PIO';
        
         PozivNaBroj := '00000000';
         IF WHeader."Month Of Wage" < 10 THEN
          PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj += FORMAT(WHeader."Month Of Wage");
        
         MakePaymentOrder;
        END;*/
        /*NK3
        //Posebni porezi
        AddTax.RESET;
        AddTax.SETRANGE(Type,AddTax.Type::Special);
        Canton.GET(CompInfo.County,CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.","Entry No.",
                               "Contribution Code","Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.",WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        //NK2 AddTaxPE.SETRANGE("Wage Calculation Type",0);
        AddTaxPE.SETFILTER("Contribution Category Code",'%1|%2','BDPIOFBIH','BDPIORS');
        IF AddTax.FINDFIRST THEN REPEAT
         AddTaxPE.SETRANGE("Contribution Code",AddTax.Code);
         FAmount := 0;
         Emp.RESET;
         IF Emp.FINDFIRST THEN REPEAT
          AddTaxPE.SETRANGE("Employee No.",Emp."No.");
          AddTaxPE.CALCSUMS("Amount Over Neto","Amount Over Wage");
          TempAmount := AddTaxPE."Amount Over Neto";
          FAmount += TempAmount;
         UNTIL Emp.NEXT = 0;
         IF FAmount > 0 THEN BEGIN
          AddTaxPS.RESET;
          AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
          AddTaxPS.SETRANGE(Code,'BD');
          AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::Special);
          AddTaxPS.SETRANGE("Add. Tax Code",AddTax.Code);
          AddTaxPS.FINDFIRST;
          InitPaymentOrder;
          SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
          SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
          SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
          Primalac1 := AddTaxPS."Payment Receiver1";
          Primalac2 := AddTaxPS."Payment Receiver2";
          Primalac3 := Canton.Description;
         Tip:=0;
         Sifra:='FBIH';
          WType:=AddTaxPE."Wage Calculation Type";
          RacunPosiljaoca := BankAccounts."Bank Account No.";
          RacunPrimaoca := AddTaxPS."Payment Account";
          BrojPoreznogObaveznika := CompInfo."Registration No.";
          VrstaPrihoda := AddTaxPS."Revenue Type";
          //NK BD Opstina := CompInfo."Municipality Code";
          Opstina := MunicipalityTemp.Code;
          PorezniPeriodOd := StartDate;
          PorezniPeriodDo := EndDate;
          Iznos := ROUND(FAmount,0.01);
          WHeaderNo := WHeader."No.";
          WHeaderEntryNo := WHeader."Entry No.";
          WPaymentType := WPaymentType::"Add. Tax";
          Contribution:='Posebni doprinosi  '+AddTaxPS."Add. Tax Code";
          {
          PozivNaBroj := '00000000';
          IF WHeader."Month Of Wage" < 10 THEN
           PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
          ELSE
           PozivNaBroj += FORMAT(WHeader."Month Of Wage");}
            PozivNaBroj :=AddTaxPS."Refer To Number";
            DatumUplate:=WHeader."Payment Date";
          MakePaymentOrder;
         END;
        UNTIL AddTax.NEXT = 0;*/

    end;

    procedure PoreziBD(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //NK2 TaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        TaxPE.SETFILTER("Contribution Category Code", '%1|%2', 'BDPIOFBIH', 'BDPIORS');
        Mun.RESET;
        FAmount := 0;
        IF Mun.FINDFIRST THEN
            REPEAT
                TaxPE.SETRANGE("Tax Number", Mun."Tax Number");
                TaxPE.CALCSUMS(Amount);
                FAmount := TaxPE.Amount;
                IF TaxPE.FINDFIRST THEN BEGIN
                    IF TaxPE."Canton Code" = 'FBIHRS' THEN
                        Canton.GET(TaxPE."Canton Code", 'RS');
                    IF TaxPE."Canton Code" = 'FBIH' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
                        Canton.GET(TaxPE."Canton Code", 'BD');
                END;
                IF FAmount > 0 THEN BEGIN


                    CLEAR(AddTaxPS);
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    AddTaxPS.SETRANGE(Code, Mun."Tax Number");
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                    AddTaxPS.FINDFIRST;

                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := 'Budžet distrikta ' + Mun.Name;
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 2;
                    Sifra := AddTaxPS.Code;
                    WType := 0;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := Mun."Tax Number";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;

                    Iznos := ROUND(FAmount, 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Porez';
                    /*
                    PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL Mun.NEXT = 0;

    end;

    procedure DoprinosiFBIHRS(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
        TempAmount2: Decimal;
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        //Nezaposleni
        WageSetup.GET;
        WageSetup.TESTFIELD("Unemployment Federation");
        WageSetup.TESTFIELD("Unemployment Canton");
        PKan := WageSetup."Unemployment Canton";
        PFed := WageSetup."Unemployment Federation";



        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Unemployment);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE.SETRANGE("Contribution Category Code", 'FBIHRS');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        //Municipality.FINDFIRST;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage", "Reported Amount From Wage");

                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        TempAmount2 := AddTaxPE."Reported Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //  Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");
                                //  CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                //  CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //CantonTemp."For Calculation" += ROUND(TempAmount*PKan/100,0.01);
                            MunicipalityTemp."For Calculation" += ROUND(TempAmount2, 0.01);
                            //  CantonTemp.MODIFY;
                            MunicipalityTemp.MODIFY;
                            FAmount += ROUND(TempAmount * PFed / 100, 0.01);
                            KAmount += ROUND(TempAmount2, 0.01);
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;
            Tip := 0;
            Sifra := 'FBIH';
            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za nezaposlenost';
            WType := 0;

            /*PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        IF KAmount > 0 THEN BEGIN
            //IF CantonTemp.FINDFIRST THEN REPEAT
            MunicipalityTemp.SETFILTER("Entity Code", '%1', 'RS');
            IF MunicipalityTemp.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    // AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                    AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);

                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := 'Opština ' + MunicipalityTemp.Name;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.01);
                    Iznos := ROUND(MunicipalityTemp."For Calculation", 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za nezaposlenost';
                    Tip := 1;
                    Sifra := (MunicipalityTemp.Code);
                    WType := 0;
                    /*PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                //UNTIL CantonTemp.NEXT = 0;
                UNTIL MunicipalityTemp.NEXT = 0;
        END;

        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        //Zdravstvo
        PKan := WageSetup."Health Canton";
        PFed := WageSetup."Health Federation";

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'FBIHRS');
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        //NK2  AddTaxPE.SETRANGE("Wage Calculation Type",0);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage", "Reported Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        TempAmount2 := AddTaxPE."Reported Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            MunicipalityTemp."For Calculation 2" += ROUND(TempAmount2, 0.01);
                            MunicipalityTemp.MODIFY;

                            FAmount += ROUND(TempAmount * PFed / 100, 0.01);
                            KAmount += ROUND(TempAmount2, 0.01);
                            //  MESSAGE(FORMAT(KAmount));
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := AddTaxPE."Wage Calculation Type";
            Tip := 1;
            Sifra := AddTaxPS.Code;
            WType := 0;
            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';

            /* PozivNaBroj := '00000000';
             IF WHeader."Month Of Wage" < 10 THEN
              PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
             ELSE
              PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        IF KAmount > 0 THEN BEGIN
            //IF CantonTemp.FINDFIRST THEN REPEAT
            MunicipalityTemp.SETFILTER("Entity Code", '%1', 'RS');
            IF MunicipalityTemp.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    //AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);

                    // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                    AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.01);
                    Iznos := ROUND(MunicipalityTemp."For Calculation 2", 0.01);
                    Tip := 1;
                    Sifra := (MunicipalityTemp.Code);
                    WType := 0;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';

                    /* PozivNaBroj := '00000000';
                     IF WHeader."Month Of Wage" < 10 THEN
                      PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                     ELSE
                      PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                //UNTIL CantonTemp.NEXT = 0;
                UNTIL MunicipalityTemp.NEXT = 0;
        END;

        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        //NK2  AddTaxPE.SETRANGE("Wage Calculation Type",0);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'BDPIORS');

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'RS');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := AddTaxPS.Code;
            WType := 0;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := '016';
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number RS";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;
        /*
        //Posebni porezi
        AddTax.RESET;
        AddTax.SETRANGE(Type,AddTax.Type::Special);
        Canton.GET(CompInfo.County,CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.","Entry No.",
                               "Contribution Code","Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.",WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type",0);
        IF AddTax.FINDFIRST THEN REPEAT
         AddTaxPE.SETRANGE("Contribution Code",AddTax.Code);
         FAmount := 0;
         Emp.RESET;
         IF Emp.FINDFIRST THEN REPEAT
          AddTaxPE.SETRANGE("Employee No.",Emp."No.");
          AddTaxPE.CALCSUMS("Amount Over Neto","Amount Over Wage");
          TempAmount := AddTaxPE."Amount Over Neto";
          FAmount += TempAmount;
         UNTIL Emp.NEXT = 0;
         IF FAmount > 0 THEN BEGIN
          AddTaxPS.RESET;
          AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
          AddTaxPS.SETRANGE(Code,'FBIH');
          AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::Special);
          AddTaxPS.SETRANGE("Add. Tax Code",AddTax.Code);
          AddTaxPS.FINDFIRST;
          InitPaymentOrder;
          SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
          SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
          SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
          Primalac1 := AddTaxPS."Payment Receiver1";
          Primalac2 := AddTaxPS."Payment Receiver2";
          Primalac3 := Canton.Description;
         Tip:=0;
         Sifra:='FBIH';
          WType:=AddTxPE."Wage calculation Type";
          RacunPosiljaoca := BankAccounts."Bank Account No.";
          RacunPrimaoca := AddTaxPS."Payment Account";
          BrojPoreznogObaveznika := CompInfo."Registration No.";
          VrstaPrihoda := AddTaxPS."Revenue Type";
          Opstina := CompInfo."Municipality Code";
          PorezniPeriodOd := StartDate;
          PorezniPeriodDo := EndDate;
          Iznos := ROUND(FAmount,0.01);
          WHeaderNo := WHeader."No.";
          WHeaderEntryNo := WHeader."Entry No.";
          WPaymentType := WPaymentType::"Add. Tax";
          Contribution:='Posebni doprinosi '+AddTaxPS."Add. Tax Code";
        
          PozivNaBroj := '00000000';
          IF WHeader."Month Of Wage" < 10 THEN
           PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
          ELSE
           PozivNaBroj += FORMAT(WHeader."Month Of Wage");
        
          MakePaymentOrder;
         END;
        UNTIL AddTax.NEXT = 0;*/

    end;

    procedure UOD(var WHeader: Record "Wage Header")
    var
        RBanks: Record "Wage/Reduction Bank";
        RBankAccounts: Record "Wage/Reduction Bank Accounts";
        Emp: Record "Employee";
        WC: Record "Wage Calculation";
        AmountForPayment: Decimal;
        AdditionAmountForPayment: Decimal;
        Single: Boolean;
        Counter: Integer;
        SingleEmp: Record "Employee";
    begin


        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        Emp.SETCURRENTKEY("Bank No.", "Bank Account Code");
        WC.SETCURRENTKEY("Wage Header No.", "Employee No.");
        WC.SETRANGE("Wage Header No.", WHeader."No.");
        //WC.SETRANGE("Entry No.",WHeader."Entry No.");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Wage);
        //NKPOrders.DELETEALL;
        IF RBanks.FINDFIRST THEN
            REPEAT
                Emp.SETRANGE("Bank Account Code");
                Emp.SETRANGE(Status, 0);
                Emp.SETRANGE("Bank No.", RBanks.Code);
                //Emp.SETFILTER("Temporary Contract Type",'%1|%2|%3',1,2,3);
                IF Emp.FINDFIRST THEN BEGIN
                    RBankAccounts.SETRANGE("Bank Code", RBanks.Code);
                    IF RBankAccounts.FINDFIRST THEN
                        REPEAT
                            Single := TRUE;
                            Counter := 0;

                            Emp.SETRANGE("Bank Account Code", FORMAT(RBankAccounts."No."));
                            Emp.SETRANGE("Refer To Number", FORMAT(RBankAccounts.n));
                            AmountForPayment := 0;
                            AdditionAmountForPayment := 0;
                            AdditionAmountForPaymentMeal := 0;
                            RegresAmount := 0;
                            CLEAR(SingleEmp);
                            IF Emp.FINDFIRST THEN
                                REPEAT
                                    WC.SETRANGE("Employee No.", Emp."No.");
                                    WC.SETRANGE(Calculated, FALSE);
                                    IF WC.FINDFIRST THEN
                                        REPEAT
                                            Counter += 1;

                                            IF Counter = 1 THEN
                                                SingleEmp.GET(Emp."No.")
                                            ELSE
                                                IF Emp."No." <> SingleEmp."No." THEN Single := FALSE;

                                            AmountForPayment += WC."Net Wage After Tax" - WC."Wage Reduction";
                                            AdditionAmountForPayment += WC.Transport;
                                            AdditionAmountForPaymentMeal += WC."Meal to pay";
                                            WC.CALCFIELDS("Regres Netto");
                                            RegresAmount += WC."Regres Netto";

                                        UNTIL WC.NEXT = 0;
                                UNTIL Emp.NEXT = 0;
                            IF AmountForPayment > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                SvrhaDoznake1 := Emp."First Name" + ' ' + Emp."Last Name";
                                //SvrhaDoznake1 :=Emp."No.";
                                SvrhaDoznake2 := SingleEmp."Refer To Number";
                                IF Single THEN
                                    SvrhaDoznake3 := SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := '';
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(CompInfo.City);
                                Primalac1 := '';

                                WType := 1;
                                Tip := 1;
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := RBankAccounts."Account No";
                                Iznos := ROUND(AmountForPayment, 0.01);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                Contribution := 'Ugovor o djelu';
                                DatumUplate := WHeader."Payment Date";
                                MakePaymentOrder;
                                WC.Calculated := TRUE;
                                WC.MODIFY;
                            END;




                        UNTIL RBankAccounts.NEXT = 0;
                END;
            UNTIL RBanks.NEXT = 0;
    end;

    procedure PlatePoBankamaPoslovnice(var WHeader: Record "Wage Header")
    var
        RBanks: Record "Wage/Reduction Bank";
        RBankAccounts: Record "Wage/Reduction Bank Accounts";
        Emp: Record "Employee";
        WC: Record "Wage Calculation";
        AmountForPayment: Decimal;
        AdditionAmountForPayment: Decimal;
        Single: Boolean;
        Counter: Integer;
        SingleEmp: Record "Employee";
    begin


        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        Emp.SETCURRENTKEY("Bank No.", "Bank Account Code");
        WC.SETCURRENTKEY("Wage Header No.", "Employee No.");
        WC.SETRANGE("Wage Header No.", WHeader."No.");
        WC.SETRANGE("Wage Calculation Type", 0);
        //WC.SETRANGE("Entry No.",WHeader."Entry No.");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Wage);
        //NKPOrders.DELETEALL;
        IF RBanks.FINDFIRST THEN
            REPEAT
                Emp.SETRANGE("Bank Account Code");
                Emp.SETRANGE("Bank No.", RBanks.Code);
                IF Emp.FINDFIRST THEN BEGIN
                    RBankAccounts.SETRANGE("Bank Code", RBanks.Code);
                    IF RBankAccounts.FINDFIRST THEN
                        REPEAT
                            Single := TRUE;
                            Counter := 0;

                            Emp.SETRANGE("Bank Account Code", FORMAT(RBankAccounts."No."));
                            AmountForPayment := 0;
                            AdditionAmountForPayment := 0;
                            AdditionAmountForPaymentMeal := 0;
                            RegresAmount := 0;
                            CLEAR(SingleEmp);
                            IF Emp.FINDFIRST THEN
                                REPEAT
                                    WC.SETRANGE("Employee No.", Emp."No.");
                                    IF WC.FINDFIRST THEN
                                        REPEAT
                                            Counter += 1;

                                            IF Counter = 1 THEN
                                                SingleEmp.GET(Emp."No.")
                                            ELSE
                                                IF Emp."No." <> SingleEmp."No." THEN Single := FALSE;
                                            IF ((WC."Contribution Category Code" = 'FBIHRS') OR (WC."Contribution Category Code" = 'BDPIORS')) THEN
                                                AmountForPayment += WC."Tax Basis (RS)" - WC."Tax (RS)" - WC."Wage Reduction"
                                            ELSE
                                                AmountForPayment += WC."Net Wage After Tax" - WC."Wage Reduction";

                                            AdditionAmountForPayment += WC.Transport;
                                            AdditionAmountForPaymentMeal += WC."Meal to pay";
                                            WC.CALCFIELDS("Regres Netto");
                                            RegresAmount += WC."Regres Netto";

                                        UNTIL WC.NEXT = 0;
                                UNTIL Emp.NEXT = 0;

                            IF AmountForPayment > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                //NK SvrhaDoznake1 := 'UPLATA PLAĆE'+' '+Emp."First Name"+' '+Emp."Last Name";
                                SvrhaDoznake1 := Emp."No.";
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';

                                IF Single THEN
                                    SvrhaDoznake3 := SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := '';
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(CompInfo.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := RBankAccounts."Account No";
                                Iznos := ROUND(AmountForPayment, 0.01);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                Contribution := 'PLAĆA';
                                // Emp.CALCFIELDS("Org Dio");
                                // OrgDio:=Emp."Org Dio";

                                MakePaymentOrder;

                            END;
                            IF AdditionAmountForPayment > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                //SvrhaDoznake1 := 'UPLATA PREVOZA'+' '+Emp."First Name"+' '+Emp."Last Name";
                                SvrhaDoznake1 := Emp."No.";
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';

                                IF Single THEN
                                    SvrhaDoznake3 := SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := Emp."No.";
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(CompInfo.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := RBankAccounts."Account No";
                                Iznos := ROUND(AdditionAmountForPayment, 0.01);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                Contribution := 'PREVOZ';
                                // Emp.CALCFIELDS("Org Dio");
                                // OrgDio:=Emp."Org Dio";
                                MakePaymentOrder;
                            END;

                            IF AdditionAmountForPaymentMeal > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                // SvrhaDoznake1 := 'UPLATA TOPLOG OBROKA' +' '+Emp."First Name"+' '+Emp."Last Name";;
                                SvrhaDoznake1 := Emp."No.";
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';

                                IF Single THEN
                                    SvrhaDoznake3 := SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := Emp."No.";
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(CompInfo.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := RBankAccounts."Account No";
                                Iznos := ROUND(AdditionAmountForPaymentMeal, 0.01);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                Contribution := 'TOPLI OBROK';
                                // Emp.CALCFIELDS("Org Dio");
                                // OrgDio:=Emp."Org Dio";
                                DatumUplate := WHeader."Payment Date";
                                MakePaymentOrder;
                            END;

                            IF RegresAmount > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                //NK SvrhaDoznake1 := 'UPLATA PLAĆE'+' '+Emp."First Name"+' '+Emp."Last Name";
                                SvrhaDoznake1 := Emp."No.";
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';

                                IF Single THEN
                                    SvrhaDoznake3 := SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := '';
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(CompInfo.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := RBankAccounts."Account No";
                                Iznos := ROUND(RegresAmount, 0.01);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                Contribution := 'REGRES';
                                // Emp.CALCFIELDS("Org Dio");
                                // OrgDio:=Emp."Org Dio";
                                DatumUplate := WHeader."Payment Date";
                                MakePaymentOrder;
                            END;
                        UNTIL RBankAccounts.NEXT = 0;
                END;
            UNTIL RBanks.NEXT = 0;
    end;

    procedure DoprinosiPoslovnice(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
        Employee: Record "Employee";
    begin

        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        //Nezaposleni
        WageSetup.GET;
        WageSetup.TESTFIELD("Unemployment Federation");
        WageSetup.TESTFIELD("Unemployment Canton");
        PKan := WageSetup."Unemployment Canton";
        PFed := WageSetup."Unemployment Federation";



        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Unemployment);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        AddTaxPE.SETRANGE("Contribution Category Code", 'FBIH');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        //Municipality.FINDFIRST;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //  Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");
                                //  CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                //  CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //CantonTemp."For Calculation" += ROUND(TempAmount*PKan/100,0.01);
                            MunicipalityTemp."For Calculation" += ROUND(TempAmount * PKan / 100, 0.01);
                            //  CantonTemp.MODIFY;
                            MunicipalityTemp.MODIFY;
                            FAmount += ROUND(TempAmount * PFed / 100, 0.01);
                            KAmount += ROUND(TempAmount * PKan / 100, 0.01);
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;
            Tip := 0;
            Sifra := 'FBIH';
            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za nezaposlenost';
            WType := AddTaxPE."Wage Calculation Type";
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        IF KAmount > 0 THEN BEGIN
            //IF CantonTemp.FINDFIRST THEN REPEAT
            IF MunicipalityTemp.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    // AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                    AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);

                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := 'Opština ' + MunicipalityTemp.Name;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.01);
                    Iznos := ROUND(MunicipalityTemp."For Calculation", 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za nezaposlenost';
                    Tip := 1;
                    Sifra := COPYSTR(FORMAT(MunicipalityTemp."DP Code"), 1, 4);
                    WType := AddTaxPE."Wage Calculation Type";
                    /*PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                //UNTIL CantonTemp.NEXT = 0;
                UNTIL MunicipalityTemp.NEXT = 0;
        END;

        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        //Zdravstvo
        PKan := WageSetup."Health Canton";
        PFed := WageSetup."Health Federation";

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'FBIH');
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            MunicipalityTemp."For Calculation 2" += ROUND(TempAmount * PKan / 100, 0.01);
                            MunicipalityTemp.MODIFY;

                            FAmount += ROUND(TempAmount * PFed / 100, 0.01);
                            KAmount += ROUND(TempAmount * PKan / 100, 0.01);
                            //  MESSAGE(FORMAT(KAmount));
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := AddTaxPE."Wage Calculation Type";
            ;
            Tip := 1;
            Sifra := AddTaxPS.Code;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        IF KAmount > 0 THEN BEGIN
            //IF CantonTemp.FINDFIRST THEN REPEAT
            IF MunicipalityTemp.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    //AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);

                    // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                    AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.01);
                    Iznos := ROUND(MunicipalityTemp."For Calculation 2", 0.01);
                    Tip := 1;
                    Sifra := COPYSTR(FORMAT(MunicipalityTemp."DP Code"), 1, 4);
                    WType := 0;

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';
                    /*
                     PozivNaBroj := '00000000';
                     IF WHeader."Month Of Wage" < 10 THEN
                      PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                     ELSE
                      PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                //UNTIL CantonTemp.NEXT = 0;
                UNTIL MunicipalityTemp.NEXT = 0;
        END;

        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETFILTER("Contribution Category Code", '%1|%2|%3', 'FBIH', 'FBIHRS', 'BDPIOFBIH');
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;


        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := AddTaxPS.Code;
            WType := 0;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        //Posebni porezi
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                        TempAmount := AddTaxPE."Amount Over Neto";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    AddTaxPS.FINDFIRST;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := 'FBIH';
                    WType := 0;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                    /*
                    PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL AddTax.NEXT = 0;

        //Posebni porezi fond
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 0);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;


                AddTaxPE.SETRANGE("Employee No.", '');
                AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                TempAmount := AddTaxPE."Amount Over Neto";
                FAmount += TempAmount;

                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    AddTaxPS.FINDFIRST;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := 'FBIH';
                    WType := 0;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                    /*
                      PozivNaBroj := '00000000';
                      IF WHeader."Month Of Wage" < 10 THEN
                       PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                      ELSE
                       PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL AddTax.NEXT = 0;

    end;

    procedure DodaciPoBankama(var WHeader: Record "Wage Header")
    var
        RBanks: Record "Wage/Reduction Bank";
        RBankAccounts: Record "Wage/Reduction Bank Accounts";
        Emp: Record "Employee";
        WC: Record "Wage Calculation";
        AmountForPayment: Decimal;
        AdditionAmountForPayment: Decimal;
        Single: Boolean;
        Counter: Integer;
        SingleEmp: Record "Employee";
    begin


        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        Emp.SETCURRENTKEY("Bank No.", "Bank Account Code");
        WA.SETCURRENTKEY("Wage Header No.", "Employee No.");
        WA.SETRANGE("Wage Header No.", WHeader."No.");
        //WC.SETRANGE("Wage Calculation Type",0);
        //WC.SETRANGE("Entry No.",WHeader."Entry No.");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Wage);
        //NKPOrders.DELETEALL;
        IF RBanks.FINDFIRST THEN
            REPEAT
                Emp.SETRANGE("Bank Account Code");
                Emp.SETRANGE("Bank No.", RBanks.Code);
                IF Emp.FINDFIRST THEN BEGIN
                    RBankAccounts.SETRANGE("Bank Code", RBanks.Code);
                    IF RBankAccounts.FINDFIRST THEN
                        REPEAT
                            Single := TRUE;
                            Counter := 0;

                            Emp.SETRANGE("Bank Account Code", FORMAT(RBankAccounts."No."));
                            AmountForPayment := 0;
                            AdditionAmountForPayment := 0;
                            AdditionAmountForPaymentMeal := 0;
                            RegresAmount := 0;
                            CLEAR(SingleEmp);
                            IF Emp.FINDFIRST THEN
                                REPEAT
                                    WA.SETRANGE("Employee No.", Emp."No.");
                                    IF WA.FINDFIRST THEN
                                        REPEAT
                                            Counter += 1;

                                            IF Counter = 1 THEN
                                                SingleEmp.GET(Emp."No.")
                                            ELSE
                                                IF Emp."No." <> SingleEmp."No." THEN Single := FALSE;

                                            AmountForPayment += WA."Amount to Pay";


                                        UNTIL WA.NEXT = 0;
                                UNTIL Emp.NEXT = 0;
                            IF AmountForPayment > 0 THEN BEGIN
                                //Payment Order
                                InitPaymentOrder;
                                SvrhaDoznake1 := 'UPLATA DODATAKA' + ' ' + Emp."First Name" + ' ' + Emp."Last Name";
                                //SvrhaDoznake1 :=Emp."No.";
                                SvrhaDoznake2 := FORMAT(WHeader."Month Of Wage") + '.' + FORMAT(WHeader."Year Of Wage") + '.';
                                IF Single THEN
                                    SvrhaDoznake3 := SingleEmp."Refer To Number"
                                ELSE
                                    SvrhaDoznake3 := '';
                                Primalac2 := UPPERCASE(RBanks.Name);
                                Primalac3 := UPPERCASE(CompInfo.City);
                                Primalac1 := '';
                                RacunPosiljaoca := BankAccounts."Bank Account No.";
                                RacunPrimaoca := RBankAccounts."Account No";
                                Iznos := ROUND(AmountForPayment, 0.01);
                                WHeaderNo := WHeader."No.";
                                WHeaderEntryNo := WHeader."Entry No.";
                                WPaymentType := WPaymentType::Wage;
                                Contribution := 'DODACI';
                                WType := 4;
                                DatumUplate := WHeader."Payment Date";
                                MakePaymentOrder;

                            END;


                        UNTIL RBankAccounts.NEXT = 0;
                END;
            UNTIL RBanks.NEXT = 0;
    end;

    procedure DoprinosiDodaci(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        //Nezaposleni
        WageSetup.GET;
        WageSetup.TESTFIELD("Unemployment Federation");
        WageSetup.TESTFIELD("Unemployment Canton");
        PKan := WageSetup."Unemployment Canton";
        PFed := WageSetup."Unemployment Federation";



        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Unemployment);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE("Contribution Category Code", 'FBIH');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        //Municipality.FINDFIRST;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //  Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");
                                //  CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                //  CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //CantonTemp."For Calculation" += ROUND(TempAmount*PKan/100,0.01);
                            MunicipalityTemp."For Calculation" += ROUND(TempAmount * PKan / 100, 0.01);
                            //  CantonTemp.MODIFY;
                            MunicipalityTemp.MODIFY;
                            FAmount += ROUND(TempAmount * PFed / 100, 0.01);
                            KAmount += ROUND(TempAmount * PKan / 100, 0.01);
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;
            Tip := 0;
            Sifra := 'FBIH';
            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za nezaposlenost';
            WType := 4;

            /*PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        IF KAmount > 0 THEN BEGIN
            //IF CantonTemp.FINDFIRST THEN REPEAT
            IF MunicipalityTemp.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    // AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                    AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);

                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := 'Opština ' + MunicipalityTemp.Name;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.01);
                    Iznos := ROUND(MunicipalityTemp."For Calculation", 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za nezaposlenost';
                    Tip := 1;
                    Sifra := COPYSTR(FORMAT(MunicipalityTemp."DP Code"), 1, 4);
                    WType := 4;
                    /*PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                //UNTIL CantonTemp.NEXT = 0;
                UNTIL MunicipalityTemp.NEXT = 0;
        END;

        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        //Zdravstvo
        PKan := WageSetup."Health Canton";
        PFed := WageSetup."Health Federation";

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'FBIH');
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            MunicipalityTemp."For Calculation 2" += ROUND(TempAmount * PKan / 100, 0.01);
                            MunicipalityTemp.MODIFY;

                            FAmount += ROUND(TempAmount * PFed / 100, 0.01);
                            KAmount += ROUND(TempAmount * PKan / 100, 0.01);
                            //  MESSAGE(FORMAT(KAmount));
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := AddTaxPE."Wage Calculation Type";
            Tip := 1;
            Sifra := AddTaxPS.Code;
            WType := 4;
            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';

            /* PozivNaBroj := '00000000';
             IF WHeader."Month Of Wage" < 10 THEN
              PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
             ELSE
              PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        IF KAmount > 0 THEN BEGIN
            //IF CantonTemp.FINDFIRST THEN REPEAT
            IF MunicipalityTemp.FIND('-') THEN
                REPEAT
                    AddTaxPS.RESET;
                    //AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Canton);
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);

                    // AddTaxPS.SETRANGE(Code,CantonTemp.Code);
                    AddTaxPS.SETRANGE(Code, MunicipalityTemp.Code);
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
                    IF AddTaxPS.FINDFIRST THEN;

                    InitPaymentOrder;

                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    //Primalac3 := CantonTemp.Description;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    //Iznos := ROUND(KAmount,0.01);
                    Iznos := ROUND(MunicipalityTemp."For Calculation 2", 0.01);
                    Tip := 1;
                    Sifra := (MunicipalityTemp.Code);
                    WType := AddTaxPE."Wage Calculation Type";

                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Doprinosi za zdravstvo';

                    /* PozivNaBroj := '00000000';
                     IF WHeader."Month Of Wage" < 10 THEN
                      PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                     ELSE
                      PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    IF Iznos > 0 THEN
                        MakePaymentOrder;
                //UNTIL CantonTemp.NEXT = 0;
                UNTIL MunicipalityTemp.NEXT = 0;
        END;

        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETFILTER("Contribution Category Code", '%1|%2|%3', 'FBIH', 'FBIHRS', 'BDPIOFBIH');
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := AddTaxPS.Code;
            WType := 4;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        //Posebni porezi
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                        TempAmount := AddTaxPE."Amount Over Neto";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    AddTaxPS.FINDFIRST;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := 'FBIH';
                    WType := 4;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";

                    /*PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL AddTax.NEXT = 0;

        //Posebni porezi fond
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;


                AddTaxPE.SETRANGE("Employee No.", '');
                AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                TempAmount := AddTaxPE."Amount Over Neto";
                FAmount += TempAmount;

                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'FBIH');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    AddTaxPS.FINDFIRST;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := 'FBIH';
                    WType := 4;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := CompInfo."Municipality Code";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi ' + AddTaxPS."Add. Tax Code";
                    /*
                    PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL AddTax.NEXT = 0;

    end;

    procedure DoprinosiDodaciBD(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        //Nezaposleni
        WageSetup.GET;

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Unemployment);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1|%2', 'BDPIOFBIH', 'BDPIORS');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        //Municipality.FINDFIRST;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //  Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");
                                //  CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                //  CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //CantonTemp."For Calculation" += ROUND(TempAmount*PKan/100,0.01);
                            MunicipalityTemp."For Calculation" += ROUND(TempAmount, 0.01);
                            //  CantonTemp.MODIFY;
                            MunicipalityTemp.MODIFY;
                            FAmount += ROUND(TempAmount, 0.01);

                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'BD');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            //BD NK Opstina := CompInfo."Municipality Code";
            Opstina := MunicipalityTemp.Code;
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;
            Tip := 0;
            Sifra := 'BD';
            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za nezaposlenost';
            WType := 4;
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;



        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        //Zdravstvo

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETFILTER("Contribution Category Code", '%1|%2', 'BDPIOFBIH', 'BDPIORS');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            //NK MunicipalityTemp."For Calculation 2" += ROUND(TempAmount*PKan/100,0.01);
                            //NK MunicipalityTemp.MODIFY;

                            FAmount += ROUND(TempAmount, 0.01);

                            //  MESSAGE(FORMAT(KAmount));
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'BD');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := 4;
            Tip := 1;
            Sifra := AddTaxPS.Code;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            //NK BD Opstina := CompInfo."Municipality Code";
            Opstina := MunicipalityTemp.Code;
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;

        /*
        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type,AddTax.Type::PIO);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.","Entry No.",
                               "Contribution Code","Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.",WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
          AddTaxPE.SETRANGE("Wage Calculation Type",0);
        AddTaxPE.SETFILTER("Contribution Category Code",'%1|2','BDPIOFBIH','BDPIORS');
        
        IF AddTax.FINDFIRST THEN REPEAT
         AddTaxPE.SETRANGE("Contribution Code",AddTax.Code);
         Emp.RESET;
         IF Emp.FINDFIRST THEN REPEAT
          AddTaxPE.SETRANGE("Employee No.",Emp."No.");
          AddTaxPE.CALCSUMS("Amount Over Wage","Amount From Wage");
          TempAmount := AddTaxPE."Amount Over Wage"+AddTaxPE."Amount From Wage";
          FAmount += TempAmount;
         UNTIL Emp.NEXT = 0;
        UNTIL AddTax.NEXT = 0;
        
        IF FAmount > 0 THEN BEGIN
         AddTaxPS.RESET;
         AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
         AddTaxPS.SETRANGE(Code,'BD');
         AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::PIO);
         AddTaxPS.FINDFIRST;
         InitPaymentOrder;
         SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
         SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
         SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
         Primalac1 := AddTaxPS."Payment Receiver1";
         Primalac2 := AddTaxPS."Payment Receiver2";
         Primalac3 := AddTaxPS."Payment Receiver3";
         Tip:=1;
         Sifra:=AddTaxPS.Code;
          WType:=AddTaxPE."Wage Calculation Type";
        
         RacunPosiljaoca := BankAccounts."Bank Account No.";
         RacunPrimaoca := AddTaxPS."Payment Account";
         BrojPoreznogObaveznika := CompInfo."Registration No.";
         VrstaPrihoda := AddTaxPS."Revenue Type";
         Opstina := CompInfo."Municipality Code";
         PorezniPeriodOd := StartDate;
         PorezniPeriodDo := EndDate;
        
         Iznos := ROUND(FAmount,0.01);
         WHeaderNo := WHeader."No.";
         WHeaderEntryNo := WHeader."Entry No.";
         WPaymentType := WPaymentType::"Add. Tax";
         Contribution:='Doprinosi PIO';
        
         PozivNaBroj := '00000000';
         IF WHeader."Month Of Wage" < 10 THEN
          PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
         ELSE
          PozivNaBroj += FORMAT(WHeader."Month Of Wage");
        
         MakePaymentOrder;
        END;*/

        //Posebni porezi
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Special);
        Canton.GET(CompInfo.County, CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1|%2', 'BDPIOFBIH', 'BDPIORS');
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                FAmount := 0;
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Neto", "Amount Over Wage");
                        TempAmount := AddTaxPE."Amount Over Neto";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
                    AddTaxPS.SETRANGE(Code, 'BD');
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Special);
                    AddTaxPS.SETRANGE("Add. Tax Code", AddTax.Code);
                    AddTaxPS.FINDFIRST;
                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 0;
                    Sifra := 'FBIH';
                    WType := 4;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    //NK BD Opstina := CompInfo."Municipality Code";
                    Opstina := MunicipalityTemp.Code;
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;
                    Iznos := ROUND(FAmount, 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Posebni doprinosi  ' + AddTaxPS."Add. Tax Code";
                    /*
                    PozivNaBroj := '00000000';
                    IF WHeader."Month Of Wage" < 10 THEN
                     PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                    ELSE
                     PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL AddTax.NEXT = 0;

    end;

    procedure DoprinosiDodaciFBIHRS(var WHeader: Record "Wage Header")
    var
        CantonTemp: Record "Canton" temporary;
        PKan: Decimal;
        PFed: Decimal;
        Canton: Record "Canton";
        Emp: Record "Employee";
        AddTax: Record "Contribution";
        AddTaxPE: Record "Contribution Per Employee";
        FAmount: Decimal;
        KAmount: Decimal;
        TempAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        StartDate: Date;
        EndDate: Date;
        Municipality: Record "Municipality";
        MunicipalityTemp: Record "Municipality";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::"Add. Tax");
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        //Nezaposleni
        WageSetup.GET;
        WageSetup.TESTFIELD("Unemployment Federation");
        WageSetup.TESTFIELD("Unemployment Canton");
        PFed := WageSetup."Unemployment Federation";



        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Unemployment);
        FAmount := 0;
        RAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE("Contribution Category Code", 'FBIHRS');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        //Municipality.FINDFIRST;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");

                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //  Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");
                                //  CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                //  CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //CantonTemp."For Calculation" += ROUND(TempAmount*PKan/100,0.01);
                            MunicipalityTemp."For Calculation" += ROUND(TempAmount * PKan / 100, 0.01);
                            //  CantonTemp.MODIFY;
                            MunicipalityTemp.MODIFY;
                            FAmount += ROUND(TempAmount * PFed / 100, 0.01);

                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompanyInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;
            Tip := 0;
            Sifra := 'FBIH';
            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za nezaposlenost';
            WType := 4;
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;


        //Nezaposleni RS
        WageSetup.GET;
        WageSetup.TESTFIELD("Unemployment Federation");
        WageSetup.TESTFIELD("Unemployment Canton");
        PKan := WageSetup."Unemployment Canton";
        PFed := WageSetup."Unemployment Federation";



        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Unemployment);
        RAmount := 0;

        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETRANGE("Contribution Category Code", 'FBIHRS');
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        //Municipality.FINDFIRST;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage", "Reported Amount From Wage");

                        TempAmount := AddTaxPE."Reported Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //  Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");
                                //  CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                //  CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;



                            RAmount += ROUND(TempAmount, 0.01);

                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF RAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'RS');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Unemployment);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;
            Tip := 0;
            Sifra := 'RS';
            Iznos := ROUND(RAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za nezaposlenost';
            WType := 4;
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;



        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");
        //Zdravstvo

        PFed := WageSetup."Health Federation";

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        FAmount := 0;
        KAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        AddTaxPE.SETRANGE("Contribution Category Code", 'FBIHRS');
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;

                            MunicipalityTemp."For Calculation 2" += ROUND(TempAmount * PKan / 100, 0.01);
                            MunicipalityTemp.MODIFY;

                            FAmount += ROUND(TempAmount * PFed / 100, 0.01);

                            //  MESSAGE(FORMAT(KAmount));
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF FAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'FBIH');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := AddTaxPE."Wage Calculation Type";
            Tip := 1;
            Sifra := AddTaxPS.Code;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;
            WType := 4;
            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;



        WageSetup.GET;
        WageSetup.TESTFIELD("Health Federation");
        WageSetup.TESTFIELD("Health Canton");

        //Zdravstvo RS

        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::Health);
        FAmount := 0;
        RAmount := 0;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        //NK CantonTemp.DELETEALL;
        //MunicipalityTemp.DELETEALL;
        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage", "Reported Amount From Wage");
                        AddTaxPE.SETRANGE("Contribution Category Code", 'FBIHRS');
                        TempAmount := AddTaxPE."Reported Amount From Wage";
                        IF TempAmount > 0 THEN BEGIN
                            //  IF NOT CantonTemp.GET(Emp.County,Emp."Entity Code") THEN BEGIN
                            IF NOT MunicipalityTemp.GET(Emp."Municipality Code") THEN BEGIN
                                //Canton.GET(Emp.County,Emp."Entity Code");

                                Municipality.GET(Emp."Municipality Code");

                                // CantonTemp.INIT;
                                MunicipalityTemp.INIT;
                                //  CantonTemp.TRANSFERFIELDS(Canton,TRUE);
                                MunicipalityTemp.TRANSFERFIELDS(Municipality, TRUE);
                                // CantonTemp.INSERT;
                                MunicipalityTemp.INSERT;
                            END;

                            //  CantonTemp.MODIFY;


                            RAmount += ROUND(TempAmount, 0.01);

                            //  MESSAGE(FORMAT(KAmount));
                        END;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;
        IF RAmount > 0 THEN BEGIN
            CLEAR(AddTaxPS);
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'RS');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Health);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            WType := 4;
            Tip := 1;
            Sifra := AddTaxPS.Code;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(RAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi za zdravstvo';
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;


        //PIO
        AddTax.RESET;
        AddTax.SETRANGE(Type, AddTax.Type::PIO);
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.",
                               "Contribution Code", "Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.", WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type", 4);
        AddTaxPE.SETFILTER("Contribution Category Code", '%1', 'BDPIORS');

        IF AddTax.FINDFIRST THEN
            REPEAT
                AddTaxPE.SETRANGE("Contribution Code", AddTax.Code);
                Emp.RESET;
                IF Emp.FINDFIRST THEN
                    REPEAT
                        AddTaxPE.SETRANGE("Employee No.", Emp."No.");
                        AddTaxPE.CALCSUMS("Amount Over Wage", "Amount From Wage");
                        TempAmount := AddTaxPE."Amount Over Wage" + AddTaxPE."Amount From Wage";
                        FAmount += TempAmount;
                    UNTIL Emp.NEXT = 0;
            UNTIL AddTax.NEXT = 0;

        IF FAmount > 0 THEN BEGIN
            AddTaxPS.RESET;
            AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Entity);
            AddTaxPS.SETRANGE(Code, 'RS');
            AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::PIO);
            AddTaxPS.FINDFIRST;
            InitPaymentOrder;
            SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
            SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
            SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
            Primalac1 := AddTaxPS."Payment Receiver1";
            Primalac2 := AddTaxPS."Payment Receiver2";
            Primalac3 := AddTaxPS."Payment Receiver3";
            Tip := 1;
            Sifra := AddTaxPS.Code;
            WType := 4;

            RacunPosiljaoca := BankAccounts."Bank Account No.";
            RacunPrimaoca := AddTaxPS."Payment Account";
            BrojPoreznogObaveznika := CompInfo."Registration No.";
            VrstaPrihoda := AddTaxPS."Revenue Type";
            Opstina := CompInfo."Municipality Code";
            PorezniPeriodOd := StartDate;
            PorezniPeriodDo := EndDate;

            Iznos := ROUND(FAmount, 0.01);
            WHeaderNo := WHeader."No.";
            WHeaderEntryNo := WHeader."Entry No.";
            WPaymentType := WPaymentType::"Add. Tax";
            Contribution := 'Doprinosi PIO';
            /*
            PozivNaBroj := '00000000';
            IF WHeader."Month Of Wage" < 10 THEN
             PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
            ELSE
             PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
            PozivNaBroj := AddTaxPS."Refer To Number";
            DatumUplate := WHeader."Payment Date";
            MakePaymentOrder;
        END;
        /*
        //Posebni porezi
        AddTax.RESET;
        AddTax.SETRANGE(Type,AddTax.Type::Special);
        Canton.GET(CompInfo.County,CompInfo."Entity Code");
        FAmount := 0;
        AddTaxPE.RESET;
        AddTaxPE.SETCURRENTKEY("Wage Header No.","Entry No.",
                               "Contribution Code","Employee No.");
        AddTaxPE.SETRANGE("Wage Header No.",WHeader."No.");
        AddTaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        AddTaxPE.SETRANGE("Wage Calculation Type",0);
        IF AddTax.FINDFIRST THEN REPEAT
         AddTaxPE.SETRANGE("Contribution Code",AddTax.Code);
         FAmount := 0;
         Emp.RESET;
         IF Emp.FINDFIRST THEN REPEAT
          AddTaxPE.SETRANGE("Employee No.",Emp."No.");
          AddTaxPE.CALCSUMS("Amount Over Neto","Amount Over Wage");
          TempAmount := AddTaxPE."Amount Over Neto";
          FAmount += TempAmount;
         UNTIL Emp.NEXT = 0;
         IF FAmount > 0 THEN BEGIN
          AddTaxPS.RESET;
          AddTaxPS.SETRANGE(Type,AddTaxPS.Type::Entity);
          AddTaxPS.SETRANGE(Code,'FBIH');
          AddTaxPS.SETRANGE("Type of Add. Tax",AddTaxPS."Type of Add. Tax"::Special);
          AddTaxPS.SETRANGE("Add. Tax Code",AddTax.Code);
          AddTaxPS.FINDFIRST;
          InitPaymentOrder;
          SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
          SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
          SvrhaDoznake3 := AddTaxPS."Assignment Purpose3";
          Primalac1 := AddTaxPS."Payment Receiver1";
          Primalac2 := AddTaxPS."Payment Receiver2";
          Primalac3 := Canton.Description;
         Tip:=0;
         Sifra:='FBIH';
          WType:=AddTxPE."Wage calculation Type";
          RacunPosiljaoca := BankAccounts."Bank Account No.";
          RacunPrimaoca := AddTaxPS."Payment Account";
          BrojPoreznogObaveznika := CompInfo."Registration No.";
          VrstaPrihoda := AddTaxPS."Revenue Type";
          Opstina := CompInfo."Municipality Code";
          PorezniPeriodOd := StartDate;
          PorezniPeriodDo := EndDate;
          Iznos := ROUND(FAmount,0.01);
          WHeaderNo := WHeader."No.";
          WHeaderEntryNo := WHeader."Entry No.";
          WPaymentType := WPaymentType::"Add. Tax";
          Contribution:='Posebni doprinosi '+AddTaxPS."Add. Tax Code";
        
          PozivNaBroj := '00000000';
          IF WHeader."Month Of Wage" < 10 THEN
           PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
          ELSE
           PozivNaBroj += FORMAT(WHeader."Month Of Wage");
        
          MakePaymentOrder;
         END;
        UNTIL AddTax.NEXT = 0;*/

    end;

    procedure PoreziDodaci(var WHeader: Record "Wage Header")
    var
        StartDate: Date;
        EndDate: Date;
        Mun: Record "Municipality";
        MunTemp: Record "Municipality" temporary;
        TaxPE: Record "Tax Per Employee";
        FAmount: Decimal;
        AddTaxPS: Record "Contribution Payments Setup";
        Canton: Record "Canton";
    begin
        CompInfo.GET;
        CompInfo.TESTFIELD("Bank No. 1");
        BankAccounts.GET(CompInfo."Bank No. 1");
        POrders.RESET;
        POrders.SETRANGE("Wage Header No.", WHeader."No.");
        POrders.SETRANGE("Wage Header Entry No.", WHeader."Entry No.");
        POrders.SETRANGE("Wage Payment Type", POrders."Wage Payment Type"::Tax);
        //NK POrders.DELETEALL;

        StartDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := DMY2DATE(1, WHeader."Month Of Wage", WHeader."Year Of Wage");
        EndDate := CALCDATE('<+1M>', EndDate);
        EndDate := CALCDATE('<-1D>', EndDate);

        TaxPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Tax Number");
        TaxPE.SETRANGE("Wage Header No.", WHeader."No.");
        //TaxPE.SETRANGE("Entry No.",WHeader."Entry No.");
        TaxPE.SETRANGE("Wage Calculation Type", 4);
        Mun.RESET;
        FAmount := 0;
        IF Mun.FINDFIRST THEN
            REPEAT
                TaxPE.SETRANGE("Tax Number", Mun."Tax Number");
                TaxPE.CALCSUMS(Amount);
                FAmount := TaxPE.Amount;
                IF TaxPE.FINDFIRST THEN BEGIN
                    IF TaxPE."Canton Code" = 'FBIHRS' THEN
                        Canton.GET(TaxPE."Canton Code", 'RS');
                    IF TaxPE."Canton Code" = 'FBIH' THEN
                        Canton.GET(TaxPE."Canton Code", 'FBIH');
                    IF ((TaxPE."Canton Code" = 'BDPIOFBIH') OR (TaxPE."Canton Code" = 'BDPIORS')) THEN
                        Canton.GET(TaxPE."Canton Code", 'BD');
                END;
                IF FAmount > 0 THEN BEGIN
                    AddTaxPS.RESET;
                    AddTaxPS.SETRANGE(Type, AddTaxPS.Type::Municipality);
                    IF Mun."DP Code" <> 'REG1' THEN
                        AddTaxPS.SETRANGE(Code, Mun.Code)
                    ELSE BEGIN
                        CompInfo.GET;
                        AddTaxPS.SETRANGE(Code, CompInfo."Municipality Code");
                    END;
                    AddTaxPS.SETRANGE("Type of Add. Tax", AddTaxPS."Type of Add. Tax"::Tax);
                    AddTaxPS.FINDFIRST;

                    InitPaymentOrder;
                    SvrhaDoznake1 := AddTaxPS."Assignment Purpose1";
                    SvrhaDoznake2 := AddTaxPS."Assignment Purpose2";
                    SvrhaDoznake3 := 'Opština ' + Mun.Name;
                    Primalac1 := AddTaxPS."Payment Receiver1";
                    Primalac2 := AddTaxPS."Payment Receiver2";
                    Primalac3 := Canton.Description;
                    Tip := 2;
                    Sifra := AddTaxPS.Code;
                    WType := 4;
                    RacunPosiljaoca := BankAccounts."Bank Account No.";
                    RacunPrimaoca := AddTaxPS."Payment Account";
                    BrojPoreznogObaveznika := CompInfo."Registration No.";
                    VrstaPrihoda := AddTaxPS."Revenue Type";
                    Opstina := Mun."Tax Number";
                    PorezniPeriodOd := StartDate;
                    PorezniPeriodDo := EndDate;

                    Iznos := ROUND(FAmount, 0.01);
                    WHeaderNo := WHeader."No.";
                    WHeaderEntryNo := WHeader."Entry No.";
                    WPaymentType := WPaymentType::"Add. Tax";
                    Contribution := 'Porez';

                    /* PozivNaBroj := '00000000';
                     IF WHeader."Month Of Wage" < 10 THEN
                      PozivNaBroj += '0'+FORMAT(WHeader."Month Of Wage")
                     ELSE
                      PozivNaBroj += FORMAT(WHeader."Month Of Wage");*/
                    PozivNaBroj := AddTaxPS."Refer To Number";
                    DatumUplate := WHeader."Payment Date";
                    MakePaymentOrder;
                END;
            UNTIL Mun.NEXT = 0;

    end;
}

