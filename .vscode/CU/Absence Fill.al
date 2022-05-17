codeunit 50304 "Absence Fill"
{

    trigger OnRun()
    begin
    end;

    var
        Calendar: Record "Base Calendar";
        CalendarChange: Record "Base Calendar Change";
        Datum: Record "Date";
        StartDate: Date;
        EndDate: Date;
        Cause: Record "Cause of Absence";
        LastEntry: Integer;
        WageSetup: Record "Wage Setup";
        DailyHours1: Decimal;
        LastArray: Integer;
        AddArray: Boolean;
        I: Integer;
        Post: Record "Post Code";
        Header: Record "Wage Header";
        WageType: Record "Wage Type";
        Window: Dialog;
        CurrRecNo: Integer;
        TotalRecNo: Integer;
        Txt001: Label 'No Wages Calendar chosen!';
        Txt002: Label 'No employees marked For Calculation!';
        Txt003: Label 'Transport is partially calculated and can''t be changed!';
        Txt004: Label 'This transportation was already paid. No changes are possible.';
        Txt005: Label 'First enter the transport header information.';
        Txt006: Label 'Employee has no Post Code entered.';
        Txt007: Label 'Meal is partially calculated and can''t be changed!';
        Txt008: Label 'This transportation was already paid. No changes are possible.';
        Txt009: Label 'First enter the meal header information.';
        ConCat: Record "Contribution Category";
        TRL: Record "Transport Line";
        ML: Record "Meal Line";
        wb: Record "Work Booklet";
        wb2: Record "Work Booklet";

    procedure CheckCalendar(var InsertIt: Boolean; Recurrence: Integer)
    begin
        InsertIt := TRUE;
        CalendarChange.RESET;
        CalendarChange.SETFILTER("Base Calendar Code", Calendar.Code);
        CalendarChange.SETFILTER(CalendarChange."Recurring System", '%1', Recurrence);
        IF Recurrence = 1 THEN
            CalendarChange.SETFILTER(CalendarChange.Date, FORMAT(Datum."Period Start"))
        ELSE
            CalendarChange.SETFILTER(CalendarChange.Day, '%1', Datum."Period No.");

        IF CalendarChange.FINDFIRST THEN
            IF Recurrence = 1 THEN
                InsertIt := CalendarChange."Paid Holiday"
            ELSE
                InsertIt := NOT (CalendarChange.Nonworking);
    end;

    procedure FillAbsence(CurrentMonth: Integer; CurrentYear: Integer; var Employee: Record "Employee")
    var
        FromDateFilter: Date;
        ToDateFilter: Date;
        CheckThem: Boolean;
        RSWorkday: Code[2];
        RSHoliday: Code[2];
        AbsenceEmp: Record "Employee Absence";
        AbsenceTemp: Record "Employee Absence" temporary;
        InsertDay: Boolean;
        InsertAnnual: Boolean;
        InsertWeekly: Boolean;
        TempEntry: Integer;
        EmploymentContract: Record "Employment Contract";
        HoursInDay: Decimal;
    begin
        AbsenceEmp.RESET;
        AbsenceEmp.LOCKTABLE;
        AbsenceTemp.RESET;
        AbsenceTemp.DELETEALL;

        StartDate := GetMonthRange(CurrentMonth, CurrentYear, TRUE);
        EndDate := GetMonthRange(CurrentMonth, CurrentYear, FALSE);

        WageSetup.GET;
        Cause.GET(WageSetup."Workday Code");
        RSWorkday := Cause."Insurance Basis";
        Cause.GET(WageSetup."Holiday Code");
        RSHoliday := Cause."Insurance Basis";


        IF NOT Calendar.GET(WageSetup."Wage Calendar Code") THEN
            ERROR(Txt001);

        CalendarChange.SETFILTER("Base Calendar Code", Calendar.Code);

        AbsenceEmp.RESET;
        IF AbsenceEmp.FIND('+') THEN
            LastEntry := AbsenceEmp."Entry No."
        ELSE
            LastEntry := 0;
        LastEntry := LastEntry + 1;

        Datum.RESET;
        Datum.SETFILTER("Period Type", '%1', 0);
        Datum.SETRANGE("Period Start", StartDate, EndDate);
        Datum.FINDFIRST;

        TempEntry := 1;



        REPEAT

            InsertAnnual := FALSE;
            InsertWeekly := FALSE;

            CheckCalendar(InsertAnnual, 1);
            CheckCalendar(InsertWeekly, 2);

            IF InsertWeekly THEN
                WITH AbsenceTemp DO BEGIN
                    INIT;
                    "Entry No." := TempEntry;
                    "Employee No." := '';
                    "From Date" := Datum."Period Start";
                    "To Date" := Datum."Period Start";
                    IF InsertAnnual THEN BEGIN
                        "Cause of Absence Code" := WageSetup."Workday Code";
                        Description := WageSetup."Workday Description";
                        "RS Code" := RSWorkday;
                    END
                    ELSE BEGIN
                        "Cause of Absence Code" := WageSetup."Holiday Code";
                        Description := WageSetup."Holiday Description";
                        "RS Code" := RSHoliday;
                    END;

                    Quantity := Employee."Hours In Day";


                    "Unit of Measure Code" := WageSetup."Hour Unit of Measure";
                    INSERT;
                    TempEntry := TempEntry + 1;
                END;
        UNTIL Datum.NEXT = 0;

        EmploymentContract.RESET;

        CurrRecNo := 0;
        TotalRecNo := Employee.COUNTAPPROX;

        Window.OPEN('Obrada radnih sati\@1@@@@@@@@@@@@@@@@@@@@@  :: Radnici\');
        Window.UPDATE(1, 0);


        IF Employee.FINDFIRST THEN
            REPEAT

                CurrRecNo += 1;
                Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));
                wb.SETFILTER("Employee No.", '%1', Employee."No.");
                wb.SETFILTER("Current Company", '%1', TRUE);
                IF Employee."Returned to Company" THEN BEGIN
                    IF wb.FIND('-') THEN BEGIN
                        IF (((wb."Ending Date" > StartDate))) then begin //ĐKOR ((wb."Ending Date">010115D) AND (wb."Ending Date"<311215D)))) THEN BEGIN
                            IF (wb."Starting Date" >= StartDate) THEN
                                FromDateFilter := wb."Starting Date"
                            ELSE
                                FromDateFilter := StartDate;
                        END;
                        //  MESSAGE(Employee."No.");
                        //MESSAGE(FORMAT(FromDateFilter));
                    END

                END;

                IF NOT Employee."Returned to Company" THEN BEGIN
                    IF wb.FIND('+') THEN BEGIN
                        IF (wb."Starting Date" >= StartDate) THEN
                            FromDateFilter := wb."Starting Date"
                        ELSE
                            FromDateFilter := StartDate;
                    END;
                END;
                wb2.SETFILTER("Employee No.", '%1', Employee."No.");
                wb2.SETFILTER("Current Company", '%1', TRUE);
                IF wb2.FIND('+') THEN BEGIN
                    IF (wb2."Ending Date" <= EndDate) THEN
                        ToDateFilter := wb2."Ending Date"
                    ELSE
                        ToDateFilter := EndDate;
                END;



                AbsenceTemp.RESET;
                AbsenceTemp.SETRANGE("From Date", FromDateFilter, ToDateFilter);
                IF AbsenceTemp.FINDFIRST THEN
                    REPEAT
                        AbsenceEmp.RESET;
                        AbsenceEmp.SETFILTER("Employee No.", Employee."No.");
                        AbsenceEmp.SETRANGE("From Date", AbsenceTemp."From Date");
                        InsertDay := TRUE;
                        IF AbsenceEmp.FINDFIRST THEN
                            REPEAT
                                Cause.GET(AbsenceEmp."Cause of Absence Code");
                                InsertDay := InsertDay AND Cause."Added To Hour Pool"; //boolean +
                            UNTIL AbsenceEmp.NEXT = 0;
                        IF InsertDay THEN BEGIN
                            AbsenceEmp.TRANSFERFIELDS(AbsenceTemp);
                            AbsenceEmp."Entry No." := LastEntry;
                            AbsenceEmp."Employee No." := Employee."No.";

                            AbsenceEmp."Statistics Group Code" := Employee."Statistics Group Code";

                            IF HoursInDay <> 0 THEN
                                AbsenceEmp.Quantity := HoursInDay;

                            AbsenceEmp.INSERT;
                            LastEntry := LastEntry + 1;
                        END;
                    UNTIL AbsenceTemp.NEXT = 0;
            UNTIL Employee.NEXT = 0
        ELSE BEGIN
            Window.CLOSE;
            MESSAGE(Txt002);
            EXIT;
        END;

        Window.CLOSE;
    end;

    procedure FillAbsence2(StartDate2: Date; EndDate2: Date; var Employee: Record "Employee")
    //komentar
    var
        FromDateFilter: Date;
        ToDateFilter: Date;
        CheckThem: Boolean;
        RSWorkday: Code[2];
        RSHoliday: Code[2];
        AbsenceEmp: Record "Employee Absence";
        AbsenceReg: Record "Employee Absence Reg";
        InsertDay: Boolean;
        InsertAnnual: Boolean;
        InsertWeekly: Boolean;
        TempEntry: Integer;
        EmploymentContract: Record "Employment Contract";
        HoursInDay: Decimal;
    begin
        AbsenceEmp.RESET;
        AbsenceEmp.LOCKTABLE;

        WageSetup.GET;
        Cause.GET(WageSetup."Workday Code");
        RSWorkday := Cause."Insurance Basis";
        Cause.GET(WageSetup."Holiday Code");
        RSHoliday := Cause."Insurance Basis";

        IF NOT Calendar.GET(WageSetup."Wage Calendar Code") THEN
            ERROR(Txt001);

        CalendarChange.SETFILTER("Base Calendar Code", Calendar.Code);

        AbsenceEmp.RESET;
        IF AbsenceEmp.FIND('+') THEN
            LastEntry := AbsenceEmp."Entry No."
        ELSE
            LastEntry := 0;
        LastEntry := LastEntry + 1;

        Datum.RESET;
        Datum.SETFILTER("Period Type", '%1', 0);
        Datum.SETRANGE("Period Start", StartDate2, EndDate2);
        Datum.FINDFIRST;

        TempEntry := 1;

        REPEAT

            InsertAnnual := FALSE;
            InsertWeekly := FALSE;

            CheckCalendar(InsertAnnual, 1);
            CheckCalendar(InsertWeekly, 2);

            IF InsertWeekly THEN
                WITH AbsenceEmp DO BEGIN
                    INIT;
                    "Entry No." := LastEntry;
                    "Employee No." := Employee."No.";
                    "From Date" := Datum."Period Start";
                    "To Date" := Datum."Period Start";
                    IF InsertAnnual THEN BEGIN
                        "Cause of Absence Code" := WageSetup."Workday Code";
                        Description := WageSetup."Workday Description";
                        "RS Code" := RSWorkday;
                    END
                    ELSE BEGIN
                        "Cause of Absence Code" := WageSetup."Holiday Code";
                        Description := WageSetup."Holiday Description";
                        "RS Code" := RSHoliday;
                    END;

                    Quantity := Employee."Hours In Day";

                    "Unit of Measure Code" := WageSetup."Hour Unit of Measure";
                    INSERT;
                    LastEntry := LastEntry + 1;
                END;
        UNTIL Datum.NEXT = 0;

        /*EmploymentContract.RESET;

        CurrRecNo := 0;
        TotalRecNo := Employee.COUNTAPPROX;

        Window.OPEN('Obrada radnih sati\@1@@@@@@@@@@@@@@@@@@@@@  :: Radnici\');
        Window.UPDATE(1, 0);


        IF Employee.FINDFIRST THEN
            REPEAT

                CurrRecNo += 1;
                Window.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));
                wb.SETFILTER("Employee No.", '%1', Employee."No.");
                wb.SETFILTER("Current Company", '%1', TRUE);
                IF Employee."Returned to Company" THEN BEGIN
                    IF wb.FIND('-') THEN BEGIN
                        IF (((wb."Ending Date" > StartDate))) then begin //ĐKOR ((wb."Ending Date">010115D) AND (wb."Ending Date"<311215D)))) THEN BEGIN
                            IF (wb."Starting Date" >= StartDate) THEN
                                FromDateFilter := wb."Starting Date"
                            ELSE
                                FromDateFilter := StartDate;
                        END;
                        //  MESSAGE(Employee."No.");
                        //MESSAGE(FORMAT(FromDateFilter));
                    END

                END;

                IF NOT Employee."Returned to Company" THEN BEGIN
                    IF wb.FIND('+') THEN BEGIN
                        IF (wb."Starting Date" >= StartDate) THEN
                            FromDateFilter := wb."Starting Date"
                        ELSE
                            FromDateFilter := StartDate;
                    END;
                END;
                wb2.SETFILTER("Employee No.", '%1', Employee."No.");
                wb2.SETFILTER("Current Company", '%1', TRUE);
                IF wb2.FIND('+') THEN BEGIN
                    IF (wb2."Ending Date" <= EndDate) THEN
                        ToDateFilter := wb2."Ending Date"
                    ELSE
                        ToDateFilter := EndDate;
                END;



                AbsenceTemp.RESET;
                AbsenceTemp.SETRANGE("From Date", FromDateFilter, ToDateFilter);
                IF AbsenceTemp.FINDFIRST THEN
                    REPEAT
                        AbsenceEmp.RESET;
                        AbsenceEmp.SETFILTER("Employee No.", Employee."No.");
                        AbsenceEmp.SETRANGE("From Date", AbsenceTemp."From Date");
                        InsertDay := TRUE;
                        IF AbsenceEmp.FINDFIRST THEN
                            REPEAT
                                Cause.GET(AbsenceEmp."Cause of Absence Code");
                                InsertDay := InsertDay AND Cause."Added To Hour Pool"; //boolean +
                            UNTIL AbsenceEmp.NEXT = 0;
                        IF InsertDay THEN BEGIN
                            AbsenceEmp.TRANSFERFIELDS(AbsenceTemp);
                            AbsenceEmp."Entry No." := LastEntry;
                            AbsenceEmp."Employee No." := Employee."No.";

                            AbsenceEmp."Statistics Group Code" := Employee."Statistics Group Code";

                            IF HoursInDay <> 0 THEN
                                AbsenceEmp.Quantity := HoursInDay;

                            AbsenceEmp.INSERT;
                            LastEntry := LastEntry + 1;
                        END;
                    UNTIL AbsenceTemp.NEXT = 0;
            UNTIL Employee.NEXT = 0
        ELSE BEGIN
            Window.CLOSE;
            MESSAGE(Txt002);
            EXIT;
        END;

        Window.CLOSE;*/
    end;

    procedure GetHourPool(CurrentMonth: Integer; CurrentYear: Integer; HoursInDay: Decimal) HourPool: Decimal
    var
        DateText: Text[30];
        DateText2: Text[30];
        FromDateFilter: Date;
        ToDateFilter: Date;
        InsertWeekly: Boolean;
    begin
        HourPool := 0;

        WageSetup.GET;

        StartDate := GetMonthRange(CurrentMonth, CurrentYear, TRUE);
        EndDate := GetMonthRange(CurrentMonth, CurrentYear, FALSE);

        IF NOT Calendar.GET(WageSetup."Wage Calendar Code") THEN BEGIN
            MESSAGE(Txt001);
            EXIT;
        END;

        CalendarChange.SETFILTER("Base Calendar Code", Calendar.Code);

        Datum.SETFILTER("Period Type", '%1', 0);
        Datum.SETRANGE("Period Start", StartDate, EndDate);
        Datum.FINDFIRST;
        REPEAT
            InsertWeekly := FALSE;
            CheckCalendar(InsertWeekly, 2);
            IF InsertWeekly THEN
                HourPool := HourPool + HoursInDay;

        UNTIL Datum.NEXT = 0;
    end;

    procedure GetMonthRange(CurrMonth: Integer; CurrYear: Integer; StartOrEnd: Boolean) ReturnDate: Date
    var
        Datum: Record "Date";
        DateText: Text[30];
    begin
        IF STRLEN(FORMAT(CurrMonth)) = 1 THEN
            DateText := '0' + FORMAT(CurrMonth) + FORMAT(CurrYear)
        ELSE
            DateText := FORMAT(CurrMonth) + FORMAT(CurrYear);

        IF StartOrEnd THEN
            EVALUATE(ReturnDate, '01' + DateText)
        ELSE BEGIN
            Datum.SETFILTER("Period Type", '%1', 2);
            Datum.SETFILTER("Period No.", FORMAT(CurrMonth));
            Datum.SETFILTER("Period Start", '01' + DateText);
            Datum.FINDFIRST;
            EVALUATE(ReturnDate, FORMAT(DATE2DMY(NORMALDATE(Datum."Period End"), 1)) + DateText);
        END;
    end;

    procedure CheckPeriod(Absence: Record "Employee Absence")
    var
        TargetDate: Date;
        ToDate: Date;
        FromDate: Date;
        DailyHours: Decimal;
        Cause: Record "Cause of Absence";
        CauseTemp: Record "Cause of Absence";
        MarkIt: Boolean;
        ConflictArray: array[100] of Integer;
        ConflictText: Text[250];
        Txt001: Label 'Conflicts were found with following entries in Absences table:';
        Txt002: Label 'Please correct these conflicts before proceeding with data entry.';
        AbsenceTemp: Record "Employee Absence";
    begin
        WageSetup.FINDFIRST;
        AbsenceTemp.LOCKTABLE;

        TargetDate := Absence."From Date";
        Cause.GET(Absence."Cause of Absence Code");
        CASE Absence."Unit of Measure Code" OF
            WageSetup."Hour Unit of Measure":
                DailyHours1 := Absence.Quantity;
            WageSetup."Day Unit of Measure":
                DailyHours1 := WageSetup."Hours in Day";
        END;
        CLEAR(ConflictArray);
        LastArray := 0;

        WHILE TargetDate <= Absence."To Date" DO BEGIN
            DailyHours := DailyHours1;
            AbsenceTemp.RESET;

            AbsenceTemp.SETFILTER("Employee No.", Absence."Employee No.");
            //AbsenceTemp.SETFILTER("Statistics Group Code", '%1', Absence."Statistics Group Code");

            AbsenceTemp.SETFILTER("From Date", '<=%1', TargetDate);
            AbsenceTemp.SETFILTER("To Date", '>=%1', TargetDate);
            AbsenceTemp.SETFILTER("Entry No.", '<>%1&<>0', Absence."Entry No.");
            AbsenceTemp.SETCURRENTKEY("Employee No.", "From Date");

            IF AbsenceTemp.FINDFIRST THEN
                REPEAT
                    CASE AbsenceTemp."Unit of Measure Code" OF
                        WageSetup."Hour Unit of Measure":
                            DailyHours := DailyHours + AbsenceTemp.Quantity;
                        WageSetup."Day Unit of Measure":
                            DailyHours := DailyHours + WageSetup."Hours in Day";
                    END;
                    CauseTemp.GET(AbsenceTemp."Cause of Absence Code");
                    MarkIt := (Absence."Cause of Absence Code" = AbsenceTemp."Cause of Absence Code") OR (DailyHours > 24);
                    //OR ((NOT(CauseTemp."Added To Hour Pool")) AND (NOT(Cause."Added To Hour Pool"))) ;
                    IF MarkIt THEN
                        MarkConflict(AbsenceTemp, Absence, ConflictArray);
                UNTIL AbsenceTemp.NEXT = 0;

            TargetDate := CALCDATE('+1D', TargetDate);
        END;



        ConflictText := '';
        /*FOR I := 1 TO LastArray DO
          ConflictText := COPYSTR(ConflictText + ' ' +  FORMAT(ConflictArray[I]) , 1, MAXSTRLEN(ConflictText));
        IF ConflictText <> '' THEN
          BEGIN
            MESSAGE(Txt001);
            MESSAGE(ConflictText);
            ERROR(Txt002);
          END;                */

    end;

    procedure MarkConflict(AbsTemp: Record "Employee Absence"; AbsEmp: Record "Employee Absence"; var EntryArray: array[100] of Integer)
    begin
        AddArray := TRUE;
        IF LastArray > 0 THEN
            FOR I := 1 TO LastArray DO
                AddArray := (EntryArray[I] <> AbsTemp."Entry No.");

        IF AddArray AND (LastArray < ARRAYLEN(EntryArray)) THEN BEGIN
            LastArray := LastArray + 1;
            EntryArray[LastArray] := AbsTemp."Entry No.";
        END;
    end;

    procedure GetHourRange(Absence: Record "Employee Absence") HourNo: Decimal
    var
        Setup: Record "Wage Setup";
    begin
        Setup.GET('');
        CASE Absence."Unit of Measure Code" OF
            Setup."Hour Unit of Measure":
                HourNo := Absence.Quantity;
            Setup."Day Unit of Measure":
                HourNo := Absence.Quantity * Setup."Hours in Day";
        END;
    end;

    procedure CalcTransport(TransHeader: Record "Transport Header")
    var
        Employee: Record "Employee";
        TransLineTemp: Record "Transport Line Temp";
        TransLine: Record "Transport Line";
        TransNo: Code[20];
        TransportAmount: Decimal;
    begin
        IF (TransHeader."No." <> '') AND (TransHeader."Year of Wage" <> 0) AND (TransHeader."Month Of Wage" <> 0) THEN BEGIN
            CASE TransHeader.Status OF
                0:
                    BEGIN
                        TransLineTemp.SETFILTER("Document No.", TransHeader."No.");
                        IF TransLineTemp.ISEMPTY THEN BEGIN
                            Employee.RESET;
                            Employee.SETFILTER("For Calculation", '%1', TRUE);
                            Employee.SETFILTER("Transport Amount", '<>%1', 0);
                            IF TRL.FIND('+') THEN
                                //TransNo:='0000000000';
                                TransNo := INCSTR(TRL."Line No.")
                            ELSE
                                TransNo := '0000000000';
                            IF Employee.FINDFIRST THEN
                                REPEAT
                                    WageType.GET(Employee."Wage Type");

                                    TransportAmount := Employee."Transport Amount";
                                    IF TransportAmount = 0 THEN
                                        IF Post.GET(Employee."Post Code", Employee.City) THEN BEGIN
                                            IF (Post."Transport Basis" > 0) AND (NOT WageType.Contract) THEN
                                                TransportAmount := Post."Transport Basis";
                                        END
                                        ELSE
                                            ERROR(Txt006);
                                    IF TransportAmount <> 0 THEN BEGIN
                                        TransLineTemp.INIT;
                                        TransNo := INCSTR(TransNo);
                                        TransLineTemp."Document No." := TransHeader."No.";
                                        TransLineTemp."Line No." := TransNo;
                                        TransLineTemp."Employee No." := Employee."No.";
                                        TransLineTemp.Workdays := TransHeader.Workdays;
                                        TransLineTemp."Basis For Transport" := TransportAmount;
                                        TransLineTemp.Amount := TransportAmount;
                                        //WG01
                                        IF ((Employee."Contribution Category Code" = 'BDPIOFBIH') OR (Employee."Contribution Category Code" = 'BDPIORS')) THEN BEGIN
                                            ConCat.SETFILTER(Code, '%1', Employee."Contribution Category Code");
                                            IF ConCat.FINDFIRST THEN BEGIN
                                                ConCat.CALCFIELDS("From Brutto");
                                                ConCat.CALCFIELDS("From Brutto(RS)");
                                                IF (Employee."Contribution Category Code" = 'BDPIORS') THEN BEGIN

                                                    TransLineTemp."Brutto Amount" := (TransLineTemp.Amount) / ((1 - ConCat."From Brutto" / 100) * 0.9);
                                                    TransLineTemp."Netto Before Tax" := (TransLineTemp."Brutto Amount") - (TransLineTemp."Brutto Amount" * (ConCat."From Brutto" / 100));
                                                END
                                                ELSE BEGIN
                                                    TransLineTemp."Brutto Amount" := (TransLineTemp.Amount) / ((1 - ConCat."From Brutto" / 100) * 0.9);
                                                    TransLineTemp."Netto Before Tax" := (TransLineTemp."Brutto Amount") - (TransLineTemp."Brutto Amount" * (ConCat."From Brutto" / 100));
                                                END;
                                            END;
                                        END;
                                        //WG01
                                        TransLineTemp.INSERT;
                                    END
                                    ELSE
                                        ERROR(Txt006);
                                UNTIL Employee.NEXT = 0
                            ELSE
                                MESSAGE(Txt002);
                        END
                        ELSE BEGIN
                            TransLineTemp.DELETEALL;
                            CalcTransport(TransHeader);
                        END;
                    END;
                1:
                    MESSAGE(Txt003);
                2:
                    MESSAGE(Txt004);
            END;
        END
        ELSE
            MESSAGE(Txt005);
    end;

    procedure CalcMeal(MealHeader: Record "Meal Header")
    var
        Employee: Record "Employee";
        MealLineTemp: Record "Meal Line Temp";
        MealLine: Record "Meal Line";
        Absences: Record "Employee Absence";
        COA: Record "Cause of Absence";
        MealNo: Code[20];
        MealAmount: Decimal;
        MealBasis: Decimal;
        MealHalfDayBasis: Decimal;
        WorkDays: array[31] of Boolean;
        WorkDaysNo: Integer;
        WorkDaysHalfDayNo: Integer;
        ReductionAmount: Decimal;
        Reduction: Record "Reduction";
        WageHeader: Record "Wage Header";
        RestDiff: Decimal;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MealCoeff: Decimal;
    begin

        IF (MealHeader."No." <> '')
           AND (MealHeader."Year Of Wage" <> 0)
           AND (MealHeader."Month Of Wage" <> 0) THEN BEGIN
            WageSetup.GET;
            StartDate := GetMonthRange(MealHeader."Month Of Wage", MealHeader."Year Of Wage", TRUE);
            EndDate := GetMonthRange(MealHeader."Month Of Wage", MealHeader."Year Of Wage", FALSE);
            CASE MealHeader.Status OF
                MealHeader.Status::Open:
                    BEGIN
                        MealLineTemp.SETFILTER("Document No.", MealHeader."No.");
                        IF MealLineTemp.ISEMPTY THEN BEGIN
                            Employee.RESET;
                            Employee.SETFILTER("For Calculation", '%1', TRUE);
                            Employee.SETRANGE(Meal, TRUE);
                            //MealNo:='0000000000';
                            IF ML.FIND('+') THEN
                                MealNo := INCSTR(ML."Line No.")
                            ELSE
                                MealNo := '0000000000';
                            IF Employee.FINDFIRST THEN
                                REPEAT
                                    WageType.GET(Employee."Wage Type");
                                    MealCoeff := Employee."Hours In Day" / 8;

                                    MealBasis := WageSetup.Meal * MealCoeff;
                                    Message(Format(MealBasis));
                                    MealHalfDayBasis := WageSetup."Meal - Half Day" * MealCoeff;
                                    Absences.RESET;
                                    Absences.SETCURRENTKEY("Employee No.", "Cause of Absence Code", "From Date", "To Date");
                                    Absences.SETFILTER("Employee No.", Employee."No.");
                                    Absences.SETFILTER("From Date", '>=%1', StartDate);
                                    Absences.SETFILTER("To Date", '<=%1', EndDate);
                                    CLEAR(WorkDays);

                                    //Full day meal:
                                    WorkDaysNo := 0;
                                    COA.RESET;
                                    COA.SETRANGE("Meal Calculated", TRUE);
                                    IF COA.FINDFIRST THEN
                                        REPEAT
                                            Absences.SETFILTER("Cause of Absence Code", '%1', COA."Code");
                                            Absences.SETFILTER(Quantity, '>0');
                                            IF Absences.FINDFIRST THEN
                                                REPEAT
                                                    IF NOT WorkDays[DATE2DMY(Absences."From Date", 1)] THEN BEGIN
                                                        WorkDays[DATE2DMY(Absences."From Date", 1)] := TRUE;
                                                        WorkDaysNo += 1;
                                                    END;
                                                UNTIL Absences.NEXT = 0;
                                        UNTIL COA.NEXT = 0;

                                    //Half day meal:
                                    WorkDaysHalfDayNo := 0;
                                    COA.RESET;
                                    COA.SETRANGE("Meal - Half Day Calculated", TRUE);
                                    IF COA.FINDFIRST THEN
                                        REPEAT
                                            Absences.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                                            Absences.SETFILTER(Quantity, '>0');
                                            IF Absences.FINDFIRST THEN
                                                REPEAT
                                                    IF NOT WorkDays[DATE2DMY(Absences."From Date", 1)] THEN BEGIN
                                                        WorkDays[DATE2DMY(Absences."From Date", 1)] := TRUE;
                                                        WorkDaysHalfDayNo += 1;
                                                    END;
                                                UNTIL Absences.NEXT = 0;
                                        UNTIL COA.NEXT = 0;

                                    /*IF WorkDaysNo<>0 THEN BEGIN
                                         MealBasis:=270/WorkDaysNo*MealCoeff;;
                                         MealHalfDayBasis:=135/ WorkDaysNo;
                                         END;
                                         //NK
                                    MealAmount := ROUND(MealBasis*WorkDaysNo + MealHalfDayBasis*WorkDaysHalfDayNo,0.01,'=');   */
                                    Message(Format(WorkDaysNo));
                                    MealAmount := MealBasis * WorkDaysNo + MealHalfDayBasis * WorkDaysHalfDayNo;
                                    IF MealAmount <> 0 THEN BEGIN
                                        MealLineTemp.INIT;
                                        MealNo := INCSTR(MealNo);
                                        MealLineTemp."Document No." := MealHeader."No.";
                                        MealLineTemp."Line No." := MealNo;
                                        MealLineTemp."Employee No." := Employee."No.";
                                        MealLineTemp.Workdays := WorkDaysNo;
                                        MealLineTemp."Basis For Meal" := MealBasis;
                                        MealLineTemp.Amount := MealAmount;
                                        //WG01
                                        IF ((Employee."Contribution Category Code" = 'BDPIOFBIH') OR (Employee."Contribution Category Code" = 'BDPIORS')) THEN BEGIN
                                            ConCat.SETFILTER(Code, '%1', Employee."Contribution Category Code");
                                            IF ConCat.FINDFIRST THEN BEGIN
                                                ConCat.CALCFIELDS("From Brutto");
                                                ConCat.CALCFIELDS("From Brutto(RS)");
                                                IF (Employee."Contribution Category Code" = 'BDPIORS') THEN BEGIN

                                                    MealLineTemp."Brutto Amount" := (MealLineTemp.Amount) / ((1 - ConCat."From Brutto" / 100) * 0.9);
                                                    MealLineTemp."Netto Before Tax" := (MealLineTemp."Brutto Amount") - (MealLineTemp."Brutto Amount" * (ConCat."From Brutto" / 100));
                                                END
                                                ELSE BEGIN
                                                    MealLineTemp."Brutto Amount" := (MealLineTemp.Amount) / ((1 - ConCat."From Brutto" / 100) * 0.9);
                                                    MealLineTemp."Netto Before Tax" := (MealLineTemp."Brutto Amount") - (MealLineTemp."Brutto Amount" * (ConCat."From Brutto" / 100));
                                                END;
                                            END;
                                        END;
                                        //WG01

                                        MealLineTemp.INSERT;
                                    END;
                                UNTIL Employee.NEXT = 0;
                        END
                        ELSE BEGIN
                            MealLineTemp.DELETEALL;
                            CalcMeal(MealHeader);
                        END;
                    END;
                MealHeader.Status::Closed:
                    MESSAGE(Txt007);
                MealHeader.Status::Locked:
                    MESSAGE(Txt008);
            END;
        END
        ELSE
            MESSAGE(Txt009);

    end;

    procedure GetHoursByType(EmployeeCode: Code[20]; WorkType: Code[20]; Month: Integer; Year: Integer) HoursByType: Decimal
    var
        AbsenceEmp: Record "Employee Absence";
    begin
        AbsenceEmp.RESET;
        AbsenceEmp.SETRANGE(AbsenceEmp."Employee No.", EmployeeCode);
        AbsenceEmp.SETRANGE("From Date", GetMonthRange(Month, Year, TRUE), GetMonthRange(Month, Year, FALSE));
        AbsenceEmp.SETRANGE("Cause of Absence Code", WorkType);
        HoursByType := 0;
        IF AbsenceEmp.FINDFIRST THEN
            REPEAT
                HoursByType := HoursByType + AbsenceEmp.Quantity;
            UNTIL AbsenceEmp.NEXT = 0;
    end;

    procedure CheckPeriodForEntries(Absence: Record "Employee Absence"; "Filter": Text[300])
    var
        TargetDate: Date;
        ToDate: Date;
        FromDate: Date;
        DailyHours: Decimal;
        Cause: Record "Cause of Absence";
        CauseTemp: Record "Cause of Absence";
        MarkIt: Boolean;
        ConflictArray: array[100] of Integer;
        ConflictText: Text[250];
        Txt001: Label 'Conflicts were found with following entries in Absences table:';
        Txt002: Label 'Please correct these conflicts before proceeding with data entry.';
        AbsenceTemp: Record "Employee Absence";
    begin
        WageSetup.FINDFIRST;
        AbsenceTemp.LOCKTABLE;

        TargetDate := Absence."From Date";
        Cause.GET(Absence."Cause of Absence Code");
        CASE Absence."Unit of Measure Code" OF
            WageSetup."Hour Unit of Measure":
                DailyHours1 := Absence.Quantity;
            WageSetup."Day Unit of Measure":
                DailyHours1 := WageSetup."Hours in Day";
        END;
        CLEAR(ConflictArray);
        LastArray := 0;

        WHILE TargetDate <= Absence."To Date" DO BEGIN
            DailyHours := DailyHours1;
            AbsenceTemp.RESET;
            //    AbsenceTemp.SETFILTER("Statistics Group Code",'%1',Filter);
            //AbsenceTemp.SETFILTER("Statistics Group Code", '%1', Absence."Statistics Group Code");

            AbsenceTemp.SETFILTER("Employee No.", Absence."Employee No.");
            AbsenceTemp.SETFILTER("From Date", '<=%1', TargetDate);
            AbsenceTemp.SETFILTER("To Date", '>=%1', TargetDate);
            AbsenceTemp.SETFILTER("Entry No.", '<>%1&<>0', Absence."Entry No.");
            AbsenceTemp.SETCURRENTKEY("Employee No.", "From Date");
            IF AbsenceTemp.FINDFIRST THEN
                REPEAT
                    CASE AbsenceTemp."Unit of Measure Code" OF
                        WageSetup."Hour Unit of Measure":
                            DailyHours := DailyHours + AbsenceTemp.Quantity;
                        WageSetup."Day Unit of Measure":
                            DailyHours := DailyHours + WageSetup."Hours in Day";
                    END;
                    CauseTemp.GET(AbsenceTemp."Cause of Absence Code");
                    MarkIt := (Absence."Cause of Absence Code" = AbsenceTemp."Cause of Absence Code") OR (DailyHours > 24);
                    //OR ((NOT(CauseTemp."Added To Hour Pool")) AND (NOT(Cause."Added To Hour Pool"))) ;
                    IF MarkIt THEN
                        MarkConflict(AbsenceTemp, Absence, ConflictArray);
                UNTIL AbsenceTemp.NEXT = 0;
            TargetDate := CALCDATE('+1D', TargetDate);
        END;

        ConflictText := '';
        /*FOR I := 1 TO LastArray DO
          ConflictText := COPYSTR(ConflictText + ' ' +  FORMAT(ConflictArray[I]) , 1, MAXSTRLEN(ConflictText));
        IF ConflictText <> '' THEN
          BEGIN
            MESSAGE(Txt001);
            MESSAGE(ConflictText);
            ERROR(Txt002);
          END;      */

    end;
}

