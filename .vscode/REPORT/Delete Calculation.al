report 50062 "Delete Calculation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Delete Calculation.rdl';

    dataset
    {
        dataitem(DataItem1; "Wage Header")
        {

            trigger OnAfterGetRecord()
            begin
                WageHeader.RESET;

                WageHeader.COPYFILTERS(DataItem1);
                //WageHeader.SETRANGE("Last Calculation In Month", TRUE);


                IF WageHeader.COUNT > 1 THEN ERROR(Txt001);
                IF WageHeader.FIND('+') THEN
                    CurrRecNo := 0;
                TotalRecNo := 12;



                // Reduction!
                /*IF WageHeader.Reduction THEN BEGIN
                
                 RedLine.SETRANGE("Wage Header No.",WageHeader."No.");
                IF Red.Line.FINDFIRST then
                 RedLine.DELETE;
                CurrRecNo += 1;*/


                TPE.SETFILTER("Wage Header No.", WageHeader."No.");
                TPE.SETRANGE("Entry No.", WageHeader."Entry No.");
                IF TPE.FINDFIRST THEN
                    TPE.DELETEALL;

                ATPE.SETFILTER("Wage Header No.", WageHeader."No.");
                ATPE.SETRANGE("Entry No.", WageHeader."Entry No.");
                IF ATPE.FINDFIRST THEN
                    ATPE.DELETEALL;

                RPE.SETFILTER("Wage Header No.", WageHeader."No.");
                RPE.SETRANGE("Wage Header Entry No.", WageHeader."Entry No.");
                IF RPE.FINDFIRST THEN
                    RPE.DELETEALL;

                WC.SETFILTER("Wage Header No.", WageHeader."No.");
                WC.SETRANGE("Entry No.", WageHeader."Entry No.");
                IF WC.FINDFIRST THEN
                    WC.DELETEALL;
                TH.SETRANGE("Year of Wage", WageHeader."Year Of Wage");
                TH.SETRANGE("Month Of Wage", WageHeader."Month Of Wage");
                IF TH.FIND('-') THEN
                    TL.SETRANGE("Document No.", TH."No.");
                IF TL.FINDFIRST THEN
                    TL.DELETEALL;

                mh.SETRANGE("Year Of Wage", WageHeader."Year Of Wage");
                mh.SETRANGE("Month Of Wage", WageHeader."Month Of Wage");
                IF mh.FIND('-') THEN
                    mh.DELETEALL;
                // ML.SETRANGE("Document No.",MH."No.");


                WA.SETRANGE("Wage Header No.", WageHeader."No.");
                WA.SETRANGE("Wage Header Entry No.", WageHeader."Entry No.");

                IF WA.FindSet() then
                    repeat
                        WaSetup.Get();
                        if WA."Wage Addition Type" = WaSetup."Meal Code FBIH" then
                            WA.Delete();
                        if WA."Wage Addition Type" = WaSetup."Meal Code FBiH Taxable" then
                            WA.Delete();

                    until WA.Next() = 0;
                CurrRecNo += 1;
                WH.SETFILTER("No.", WageHeader."No.");
                //WageHeader.SETRANGE("Entry No.",WageHeader."Entry No.");


                TPE.DELETEALL(TRUE);

                ATPE.DELETEALL(TRUE);

                RPE.DELETEALL(TRUE);

                WC.DELETEALL(TRUE);
                WH.DELETEALL(TRUE);
                IF WageHeader.Transportation THEN
                    TL.DELETEALL(TRUE);

                IF WageHeader.Transportation THEN
                    TL.DELETEALL(TRUE);
                CurrRecNo += 1;

                TH.DELETEALL;

                IF WageHeader.Meal THEN
                    ML.DELETEALL(TRUE);
                CurrRecNo += 1;


                WA.MODIFYALL("Calculated Amount", 0);
                WA.MODIFYALL("Wage Header No.", '');
                WA.MODIFYALL("Wage Header Entry No.", 0);
                CurrRecNo += 1;

                WLE.SETFILTER("Document No.", WageHeader."No.");
                //WLE.SETRANGE("Wage Header Entry No.",WageHeader."Entry No.");
                IF WLE.FINDFIRST THEN
                    WLE.DELETEALL(TRUE);


                WVE.SETFILTER("Document No.", WageHeader."No.");
                WVE.SETRANGE("Wage Header Entry No.", WageHeader."Entry No.");
                IF WVE.FINDFIRST THEN
                    WVE.DELETEALL(TRUE);

                /*
                IF WVE.FIND('-') THEN REPEAT
                 WLE.GET(WVE."Wage Ledger Entry No.");
                 WLE.MARK(TRUE);
                UNTIL WVE.NEXT = 0;  */

                CurrRecNo += 1;


                WLE.MARKEDONLY(TRUE);
                WLE.DELETEALL(TRUE);
                /*
                WageHeader.Status := WageHeader.Status::"0";
                WageHeader.MODIFY;         */

                CurrRecNo += 1;


                tpe2.SETFILTER("Wage Header No.", ' ');
                tpe2.SETRANGE(Amount, 0);
                IF tpe2.FINDFIRST THEN
                    tpe2.DELETEALL;

                //WG

                StartDate := AbsenceFill.GetMonthRange("Month Of Wage", "Year Of Wage", TRUE);
                EndDate := AbsenceFill.GetMonthRange("Month Of Wage", "Year Of Wage", FALSE);

                EA.SETFILTER("From Date", '%1..%2', StartDate, EndDate);
                IF EA.FINDSET THEN
                    REPEAT
                        EA.Calculated := FALSE;
                        EA."Wage Header No." := '';
                        EA."Wage Calculation No." := '';
                        EA.MODIFY;
                    UNTIL EA.NEXT = 0;



                MESSAGE(Txt003);

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        WageHeader: Record "Wage Header";
        WaSetup: Record "Wage Setup";
        Txt003: Label 'Calculation was succesfully deleted';
        Txt001: Label 'This calculation is not closed';
        Err01: Label 'You have to choose only one calculation!';
        CurrRecNo: Integer;
        TotalRecNo: Integer;
        RedLine: Record "Reduction per Wage";
        TPE: Record "Tax Per Employee";
        WLE: Record "Wage Ledger Entry";
        WVE: Record "Wage Value Entry";
        ML: Record "Meal Header";
        WA: Record "Wage Addition";
        WC: Record "Wage Calculation";
        RPE: Record "Reduction per Wage";
        ATPE: Record "Contribution Per Employee";
        TH: Record "Transport Header";
        TL: Record "Transport Line";
        Window: Dialog;
        mh: Record "Meal Header";
        WH: Record "Wage Header";
        tpe2: Record "Tax Per Employee";
        AbsenceFill: Codeunit "Absence Fill";
        StartDate: Date;
        EndDate: Date;
        EA: Record "Employee Absence";
        EMP: Record Employee;
}

