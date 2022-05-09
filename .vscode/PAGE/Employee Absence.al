page 51129 "Employee Absence"
{
    // // Added fields "In Addition to Regular Work"

    Caption = 'Employee Absence';
    DataCaptionFields = "Employee No.";
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Employee Absence Reg";
    //SourceTableView = SORTING("Employee No.", From Date);


    layout
    {
        area(content)
        {
            /*field(EmployeeFilter; EmployeeFilter)
            {
                Caption = 'Employee No.';

                trigger OnLookup(var Text: Text): Boolean
                begin
                    EXIT(EmployeeLookup(Text, FALSE));
                end;

                trigger OnValidate()
                begin
                    EmployeeFilterOnAfterValidate;
                end;
            }*/

            /*field(Dim1Filter; Dim1Filter)
            {
                CaptionClass = '1,2,1';

                trigger OnLookup(var Text: Text): Boolean
                begin
                    EXIT(DimFilterLookup(Text, 1));
                end;

                trigger OnValidate()
                begin
                    Dim1FilterOnAfterValidate;
                end;
            }*/
            /*field(Dim2Filter; Dim2Filter)
            {
                CaptionClass = '1,2,2';

                trigger OnLookup(var Text: Text): Boolean
                begin
                    EXIT(DimFilterLookup(Text, 2));
                end;

                trigger OnValidate()
                begin
                    Dim2FilterOnAfterValidate;
                end;
            }*/
            /*field(Year; Year)
            {
                BlankZero = true;
                Caption = 'Year';

                trigger OnValidate()
                begin
                    YearOnAfterValidate;
                end;
            }*/
            /*field(Month; Month)
            {
                BlankZero = true;
                Caption = 'Month';

                trigger OnValidate()
                begin
                    MonthOnAfterValidate;
                end;
            }*/
            repeater(s)
            {
                /*field("Entry No."; "Entry No.")
                {
                    Editable = false;
                    Visible = false;
                }*/
                field("Employee No."; "Employee No.")
                {

                    /*trigger OnValidate()
                    begin


                        IF "Employee No." <> '' THEN BEGIN
                            //Employee.SETFILTER("Employee No.", "empl");
                            IF Employee.FINDFIRST THEN BEGIN
                                "First Name" := Employee."First Name";
                                "Last Name" := Employee."Last Name";
                            END;
                        END;

                    end;*/


                }

                field("First Name"; "First Name")
                {
                    Editable = false;
                }

                field("Last Name"; "Last Name")
                {
                    Editable = false;
                }
                /*field(GetEmployeeName; GetEmployeeName)
                {
                    Caption = 'Name';
                }*/

                field("From Date"; "From Date")
                {


                }
                field("To Date"; "To Date")
                {

                }

                field("Cause of Absence Code"; "Cause of Absence Code")
                {
                }

                field(Description; Description)
                {

                }

                field("Quantity"; "Quantity")
                {

                }


                field(Approved; Approved)
                {
                    Editable = true;
                }

            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("A&bsence")
            {
                Caption = 'A&bsence';
                /*action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    /* RunPageLink = Table Name=CONST(Employee Absence),
                                   Table Line No.=FIELD(Entry No.);*/
                /*}*/

                /*action("Overview by &Categories") STAJALO
                {
                    Caption = 'Overview by &Categories';
                    "Absence Overview by Categories";
                    RunPageLink = "Employee No." = FIELD("Employee No.");

                }*/
                /*action("Overview by &Periods")
                {
                    Caption = 'Overview by &Periods';
                    RunObject = Page "Absence Overview by Periods";
                }*/

                /*action("&Reset Quantity")
                {
                    Caption = '&Reset Quantity';
                    Image = UnApply;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        ResetQuantity;
                    end;
                }*/

                action("&Approve All")
                {
                    Caption = '&Approve All';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        SetApprove(TRUE);
                    end;
                }

                action("&Unapprove All")
                {
                    Caption = '&Unapprove All';
                    Image = ResetStatus;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    begin
                        SetApprove(FALSE);
                    end;
                }

            }
        }
        area(processing)
        {
            /*action("Previous Year")
            {
                Caption = 'Previous Year';
            Image = PreviousRecord;
            Promoted = true;
            PromotedCategory = Process;
            PromotedIsBig = true;
            ToolTip = 'Previous Year';

                trigger OnAction()
    begin
        CurrPage.SAVERECORD;
        //PrevYear;
        CurrPage.UPDATE(FALSE);
    end;

            
            /*action("Next Year")
            {
                Caption = 'Next Year';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Next Year';

                trigger OnAction()
                begin
                    CurrPage.SAVERECORD;
                    //NextYear;
                    CurrPage.UPDATE(FALSE);
                end;
            }

            action("Previous Month")
            {
                Caption = 'Previous Month';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Previous Month';

                trigger OnAction()
                begin
                    CurrPage.SAVERECORD;
                    //PrevMonth;
                    CurrPage.UPDATE(FALSE);
                end;
            }*/

            /*action("Next Month")
            {
                Caption = 'Next Month';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Next Month';

                trigger OnAction()
                begin
                    CurrPage.SAVERECORD;
                    //NextMonth;
                    CurrPage.UPDATE(FALSE);
                end;
            }*/

            action("&Edit")
            {
                Caption = '&Edit';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    SetEditable(NOT CurrPage.EDITABLE);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //OnAfterGetCurrRecord;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //EXIT(TestRecordValid);

    end;

    trigger OnModifyRecord(): Boolean
    begin
        //EXIT(TestRecordValid);
    end;



    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;


    /*trigger OnNewRecord(BelowxRec: Boolean)
    begin
        recEmployee.RESET;
        recEmployee.SETFILTER("No.", EmployeeFilter);
        IF (recEmployee.COUNT = 1) THEN BEGIN
            recEmployee.FIND('-');
            "Employee No." := recEmployee."No.";
        END ELSE BEGIN
            IF (BelowxRec) AND (xRec."Employee No." <> '') THEN BEGIN
                IF recEmployee.GET(xRec."Employee No.") THEN BEGIN
                    "Employee No." := xRec."Employee No.";
                END;
            END;
        END;
        //TestDateValid; //DODANO
        //OnAfterGetCurrRecord;
    end;*/



    trigger OnOpenPage()
    begin
        //  GetInitialFilters;


    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //SaveFilters;
    end;

    var

        HRSetup: Record "Human Resources Setup";
        //UnitOfMeasure: Record "Human Resource Unit of Measure";
        Employee: Record "Employee";
        Year: Integer;
        Month: Integer;
        CurrPeriodStartDate: Date;
        CurrPeriodEndDate: Date;

        recEmplAbsence: Record "Employee Absence";
        recEmplAbsenceTemp: Record "Employee Absence" temporary;
        Dim1Filter: Code[250];
        Dim2Filter: Code[250];
        //"Dimension Value List"; STAJALO
        recDimValue: Record "Dimension Value";
        EmployeeFilter: Code[250];
        FormEmployeeList: Page "Employee List";
        recEmployee: Record "Employee";
        Text001: Label 'Set filters do not allow entry';
        CalendarMgt: Codeunit "Absence Fill";
        CauseOfAbsence: Record "Cause of Absence";
        Text002: Label 'Set Approved to %1 for %2 records?';
        txtView: Text[1024];
        txtView2: Text[1024];
        NewDim1Filter: Code[250];
        NewDim2Filter: Code[250];
        NewEmployeeFilter: Code[250];
        SettingNewFilters: Boolean;
        [InDataSet]
        ChangeAllowedVisible: Boolean;

        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';

    procedure SetEditable(NewEditable: Boolean)
    begin
        CurrPage.EDITABLE(NewEditable);
        ChangeAllowedVisible := CurrPage.EDITABLE;
        IF (NOT CurrPage.EDITABLE) THEN
            IF Rec.NEXT <> 0 THEN Rec.NEXT(-1);
    end;

    /*procedure DimFilterLookup(var Text: Text[1024]; DimNo: Integer) ret: Boolean STAJALO
    begin
        recDimValue.RESET;
        recDimValue.SETRANGE("Global Dimension No.", DimNo);
        recDimValue.Code := Text;
        CLEAR(FormDimValues);
        FormDimValues.LOOKUPMODE := TRUE;
        FormDimValues.SETTABLEVIEW(recDimValue);
        FormDimValues.SETRECORD(recDimValue);
        IF ACTION::LookupOK = FormDimValues.RUNMODAL THEN BEGIN
            FormDimValues.GETRECORD(recDimValue);
            IF (STRLEN(Text) > 0) THEN BEGIN
                IF Text[STRLEN(Text)] IN ['.', '|', '&'] THEN
                    Text += recDimValue.Code
                ELSE
                    Text := recDimValue.Code;
            END ELSE BEGIN
                Text := recDimValue.Code;
            END;
            EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;*/

    procedure EmployeeLookup(var Text: Text[1024]; WithDimFilters: Boolean) ret: Boolean
    begin
        recEmployee.RESET;
        recEmployee."No." := Text;
        IF WithDimFilters THEN BEGIN
            recEmployee.SETFILTER("Global Dimension 1 Code", Dim1Filter);
            recEmployee.SETFILTER("Global Dimension 2 Code", Dim2Filter);
        END;
        CLEAR(FormEmployeeList);
        FormEmployeeList.LOOKUPMODE := TRUE;
        FormEmployeeList.SETTABLEVIEW(recEmployee);
        FormEmployeeList.SETRECORD(recEmployee);
        IF ACTION::LookupOK = FormEmployeeList.RUNMODAL THEN BEGIN
            FormEmployeeList.GETRECORD(recEmployee);
            IF (STRLEN(Text) > 0) THEN BEGIN
                IF Text[STRLEN(Text)] IN ['.', '|', '&'] THEN
                    Text += recEmployee."No."
                ELSE
                    Text := recEmployee."No.";
            END ELSE BEGIN
                Text := recEmployee."No.";
            END;
            EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;

    /* local procedure GetInitialFilters()
    begin
        IF NOT ISSERVICETIER THEN BEGIN
            CurrPeriodStartDate := 0D;
            CurrPeriodEndDate := 20180325D;
            Year := 0;
            Month := 0;
            CLEAR(Dim1Filter);
            CLEAR(Dim2Filter);
            CLEAR(EmployeeFilter);

            IF GETFILTER("From Date") <> '' THEN BEGIN
                Period.RESET;
                Period.SETRANGE("Period Type", Period."Period Type"::Date);
                COPYFILTER("From Date", Period."Period Start");
                IF Period.FIND('-') THEN BEGIN
                    CurrPeriodStartDate := DMY2DATE(1, DATE2DMY(Period."Period Start", 2), DATE2DMY(Period."Period Start", 3));
                    CurrPeriodEndDate := CALCDATE('<+1M><-1D>', CurrPeriodStartDate);
                    Month := DATE2DMY(CurrPeriodStartDate, 2);
                    Year := DATE2DMY(CurrPeriodStartDate, 3);
                    SetPeriod;
                END;
            END;

            IF GETFILTER("Employee No.") <> '' THEN BEGIN
                EmployeeFilter := GETFILTER("Employee No.");
                SetEmployee;
            END;

            /*IF GETFILTER("Global Dimension 1 Code") <> '' THEN BEGIN
                Dim1Filter := GETFILTER("Global Dimension 1 Code");
                SetGlobalDim1;
            END;
            IF GETFILTER("Global Dimension 2 Code") <> '' THEN BEGIN
                Dim2Filter := GETFILTER("Global Dimension 2 Code");
                SetGlobalDim2;
            END;
        END ELSE BEGIN
            IF SettingNewFilters THEN BEGIN
                Dim1Filter := NewDim1Filter;
                Dim2Filter := NewDim2Filter;
                EmployeeFilter := NewEmployeeFilter;
            END;
            SetPeriod;
            SetEmployee;
            /*SetGlobalDim1;
            SetGlobalDim2;
        END;
    end;*/

    /*procedure SaveFilters()
    begin
        IF NOT ISSERVICETIER THEN BEGIN
            SETRANGE("From Date");
            SETRANGE("Employee No.");
            //SETRANGE("Global Dimension 1 Code");
            //SETRANGE("Global Dimension 2 Code");
            //FILTERGROUP(2);
            recEmplAbsence.RESET;
            COPYFILTER("From Date", recEmplAbsence."From Date");
            COPYFILTER("Employee No.", recEmplAbsence."Employee No.");
            //COPYFILTER("Global Dimension 1 Code", recEmplAbsence."Global Dimension 1 Code");
            //COPYFILTER("Global Dimension 2 Code", recEmplAbsence."Global Dimension 2 Code");
            //FILTERGROUP(0);
            recEmplAbsence.COPYFILTER("From Date", Rec."From Date");
            recEmplAbsence.COPYFILTER("Employee No.", Rec."Employee No.");
            /*recEmplAbsence.COPYFILTER("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
            recEmplAbsence.COPYFILTER("Global Dimension 2 Code", Rec."Global Dimension 2 Code");*/
    /*END;
end;*/

    /*local procedure PrevMonth()
    begin
        IF (CurrPeriodStartDate = 0D) THEN BEGIN
            CurrPeriodStartDate := DMY2DATE(1, DATE2DMY(WORKDATE, 2), DATE2DMY(WORKDATE, 3));
        END;
        CurrPeriodStartDate := CALCDATE('<-1M>', CurrPeriodStartDate);
        CurrPeriodEndDate := CALCDATE('<+1M><-1D>', CurrPeriodStartDate);
        Month := DATE2DMY(CurrPeriodStartDate, 2);
        Year := DATE2DMY(CurrPeriodStartDate, 3);
        SetPeriod;
    end;

    local procedure NextMonth()
    begin
        IF CurrPeriodStartDate = 0D THEN BEGIN
            CurrPeriodStartDate := DMY2DATE(1, DATE2DMY(WORKDATE, 2), DATE2DMY(WORKDATE, 3));
        END;
        CurrPeriodStartDate := CALCDATE('<+1M>', CurrPeriodStartDate);
        CurrPeriodEndDate := CALCDATE('<+1M><-1D>', CurrPeriodStartDate);
        Month := DATE2DMY(CurrPeriodStartDate, 2);
        Year := DATE2DMY(CurrPeriodStartDate, 3);
        SetPeriod;
    end;

    local procedure PrevYear()
    begin
        IF (CurrPeriodStartDate = 0D) THEN BEGIN
            CurrPeriodStartDate := DMY2DATE(1, DATE2DMY(WORKDATE, 2), DATE2DMY(WORKDATE, 3));
        END;
        CurrPeriodStartDate := CALCDATE('<-1Y>', CurrPeriodStartDate);
        CurrPeriodEndDate := CALCDATE('<+1M><-1D>', CurrPeriodStartDate);
        Month := DATE2DMY(CurrPeriodStartDate, 2);
        Year := DATE2DMY(CurrPeriodStartDate, 3);
        SetPeriod;
    end;

    local procedure NextYear()
    begin
        IF CurrPeriodStartDate = 0D THEN BEGIN
            CurrPeriodStartDate := DMY2DATE(1, DATE2DMY(WORKDATE, 2), DATE2DMY(WORKDATE, 3));
        END;
        CurrPeriodStartDate := CALCDATE('<+1Y>', CurrPeriodStartDate);
        CurrPeriodEndDate := CALCDATE('<+1M><-1D>', CurrPeriodStartDate);
        Month := DATE2DMY(CurrPeriodStartDate, 2);
        Year := DATE2DMY(CurrPeriodStartDate, 3);
        SetPeriod;
    end;*/

    procedure SetPeriod()
    begin
        IF (Year IN [1900 .. 2999]) AND (Month IN [0 .. 12]) THEN BEGIN
            IF (Month = 0) THEN Month := 1;
            CurrPeriodStartDate := DMY2DATE(1, Month, Year);
            CurrPeriodEndDate := CALCDATE('<+1M><-1D>', CurrPeriodStartDate);
            SETRANGE("From Date");
            //FILTERGROUP(2);
            SETRANGE("From Date", CurrPeriodStartDate, CurrPeriodEndDate);
            //FILTERGROUP(0);
        END ELSE BEGIN
            Year := 0;
            Month := 0;
            CurrPeriodStartDate := 0D;
            CurrPeriodEndDate := 20180325D;
            //FILTERGROUP(2);
            SETRANGE("From Date");
            //FILTERGROUP(0);
        END;
    end;

    procedure SetEmployee()
    begin
        IF EmployeeFilter <> '' THEN BEGIN
            SETRANGE("Employee No.");
            //FILTERGROUP(2);
            SETFILTER("Employee No.", EmployeeFilter);
            //FILTERGROUP(0);
        END ELSE BEGIN
            SETRANGE("Employee No.");
            //FILTERGROUP(2);
            SETRANGE("Employee No.");
            //FILTERGROUP(0);
        END;
    end;

    /*local procedure SetGlobalDim1()
    begin
        IF Dim1Filter <> '' THEN BEGIN
            SETRANGE("Global Dimension 1 Code");
            FILTERGROUP(2);
            SETFILTER("Global Dimension 1 Code", Dim1Filter);
            FILTERGROUP(0);
        END ELSE BEGIN
            SETRANGE("Global Dimension 1 Code");
            FILTERGROUP(2);
            SETRANGE("Global Dimension 1 Code");
            FILTERGROUP(0);
        END;
    end;*/

    /*local procedure SetGlobalDim2()
    begin
        IF Dim2Filter <> '' THEN BEGIN
            SETRANGE("Global Dimension 2 Code");
            FILTERGROUP(2);
            SETFILTER("Global Dimension 2 Code", Dim2Filter);
            FILTERGROUP(0);
        END ELSE BEGIN
            SETRANGE("Global Dimension 2 Code");
            FILTERGROUP(2);
            SETRANGE("Global Dimension 2 Code");
            FILTERGROUP(0);
        END;
    end;*/

    /*procedure TestRecordWithinFilter(bOnlyKeyFields: Boolean): Boolean
    begin
        recEmplAbsenceTemp.RESET;
        recEmplAbsenceTemp.DELETEALL;
        recEmplAbsenceTemp.INIT;
        recEmplAbsenceTemp.TRANSFERFIELDS(Rec);
        recEmplAbsenceTemp.INSERT;
        recEmplAbsenceTemp.RESET;
        //FILTERGROUP(2);
        COPYFILTER("Employee No.", recEmplAbsenceTemp."Employee No.");
        /*COPYFILTER("Global Dimension 1 Code", recEmplAbsenceTemp."Global Dimension 1 Code");
        COPYFILTER("Global Dimension 2 Code", recEmplAbsenceTemp."Global Dimension 2 Code");*/
    /*IF NOT bOnlyKeyFields THEN BEGIN
        COPYFILTER("From Date", recEmplAbsenceTemp."From Date");
    END;
    //FILTERGROUP(0);
    recEmplAbsenceTemp.INIT;
    recEmplAbsenceTemp.TRANSFERFIELDS(Rec);
    IF NOT recEmplAbsenceTemp.FIND('=') THEN
        ERROR(Text001);
    EXIT(TRUE);
end;*/

    /*procedure TestRecordValid(): Boolean POGLEDATI
    begin
        IF NOT Employee.GET("Employee No.") THEN
            FIELDERROR("Employee No.");
        IF "From Date" = 0D THEN
            FIELDERROR("From Date");
        IF "To Date" = 0D THEN
            FIELDERROR("To Date");
        IF "To Date" < "From Date" THEN
            FIELDERROR("To Date");
        IF (DATE2DMY("To Date", 2) <> DATE2DMY("From Date", 2))
        OR (DATE2DMY("To Date", 3) <> DATE2DMY("From Date", 3))
        THEN
            FIELDERROR("To Date");
        IF NOT TestVacationOK THEN
            EXIT(FALSE);
        EXIT(TestRecordWithinFilter(FALSE));
    end;*/

    /*procedure FillHours(inFieldNo: Integer)
    var
        l_Date: Date;
        l_WorkHoursCode: Code[10];
        l_WorkHours: Decimal;
        l_CauseOfAbsence1: Record "Cause of Absence";
        l_CauseOfAbsence2: Record "Cause of Absence";
        l_oldUoM: Code[10];
    begin
        //Setup.GET;
        HRSetup.GET;
        IF recEmployee.GET("Employee No.") THEN BEGIN
            l_oldUoM := "Unit of Measure Code";
            IF ("From Date" <> 0D) AND ("To Date" <> 0D) THEN BEGIN
                IF ABS("From Date" - "To Date") > 60 THEN BEGIN
                    IF (inFieldNo = FIELDNO("From Date")) THEN BEGIN
                        FIELDERROR("From Date");
                    END ELSE BEGIN
                        FIELDERROR("To Date");
                    END;
                END;
                /* VALIDATE(Quantity, CalendarMgt.GetWorkHoursForEmployee("Employee No.", "From Date", "To Date"));
                 IF (Setup."Auto-fill Missing Hours") THEN BEGIN
                     IF l_CauseOfAbsence1.GET("Cause of Absence Code") THEN BEGIN
                         IF (l_CauseOfAbsence1."Work Type" = l_CauseOfAbsence1."Work Type"::Vacation) THEN BEGIN
                             FOR l_Date := "From Date" TO "To Date" DO BEGIN
                                 CalendarMgt.GetEmployeeWorkHoursCode("Employee No.", l_Date, l_WorkHoursCode, l_WorkHours);
                                 l_CauseOfAbsence2.GET(l_WorkHoursCode);
                                 IF (l_CauseOfAbsence2."Work Type" = l_CauseOfAbsence2."Work Type"::Holiday) THEN BEGIN
                                     Quantity := Quantity - l_WorkHours;
                                 END;
                             END;
                             IF Quantity < 0 THEN
                                 Quantity := 0;
                             VALIDATE(Quantity, Quantity);
                         END;
                     END;
                 END;
                 VALIDATE("Unit of Measure Code", HRSetup."Base Unit of Measure");
                 IF (l_oldUoM <> '') AND (l_oldUoM <> "Unit of Measure Code") THEN BEGIN
                     ConvertToUnitOfMeasure(l_oldUoM);
                 END ELSE BEGIN
                     IF Setup."Day Unit of Measure Code" <> '' THEN BEGIN
                         UnitOfMeasure.GET(Setup."Day Unit of Measure Code");
                         UnitOfMeasure.TESTFIELD("Qty. per Unit of Measure");
                         VALIDATE(Quantity, Quantity / UnitOfMeasure."Qty. per Unit of Measure");
                         VALIDATE("Unit of Measure Code", Setup."Day Unit of Measure Code");
                     END;
                 END;*/
    /*END;
END;
end;*/

    procedure TestVacationOK(): Boolean
    var
        // l_Vacation: Record payrol;
        l_AvailableHours: Decimal;
        l_Absence: Record "Employee Absence";
    begin
        /* IF "Work Type" <> "Work Type"::Vacation THEN
             EXIT(TRUE);
         IF "Bound to Year" <= 0 THEN
             FIELDERROR("Bound to Year");*/
        /* IF NOT l_Vacation.GET("Employee No.", "Bound to Year") THEN
             FIELDERROR("Bound to Year");
         l_AvailableHours := l_Vacation."Available Hours";
         l_Absence.RESET;
         l_Absence.SETCURRENTKEY("Employee No.", "Work Type", "Bound to Year");
         l_Absence.SETRANGE("Employee No.", "Employee No.");
         l_Absence.SETRANGE("Work Type", l_Absence."Work Type"::Vacation);
         l_Absence.SETRANGE("Bound to Year", "Bound to Year");
         l_Absence.SETFILTER("Entry No.", '<> %1', "Entry No.");
         IF l_Absence.FIND('-') THEN
             REPEAT
                 l_AvailableHours -= l_Absence."Quantity (Base)";
             UNTIL l_Absence.NEXT = 0;
         l_AvailableHours -= "Quantity (Base)";
         IF l_AvailableHours < 0 THEN
             FIELDERROR("Quantity (Base)");
         EXIT(TRUE);*/
    end;

    procedure GetEmployeeName(): Text[250]
    begin
        IF recEmployee.GET("Employee No.") THEN BEGIN
            EXIT(recEmployee.FullName);
        END;
    end;

    /*local procedure PrintVacationResolution()  MOŽDA TREBA
    var
        ReportVacationResolution: Report "52015835"; 
        lEmployee: Record "Employee";
    begin
        lEmployee.INIT;
        lEmployee.SETRANGE("No.", "Employee No.");
        CLEAR(ReportVacationResolution);
        IF "From Date" <> 0D THEN
            ReportVacationResolution.SetOnDate("From Date");
        ReportVacationResolution.SETTABLEVIEW(lEmployee);
        ReportVacationResolution.RUNMODAL;
    end;*/

    /*procedure ResetQuantity()
    begin
        FillHours(FIELDNO("To Date"));
        CurrPage.UPDATE(TRUE);
    end;*/

    procedure SetApprove(inNewValue: Boolean)
    begin
        txtView := Rec.GETVIEW;
        FILTERGROUP(2);
        txtView2 := Rec.GETVIEW;
        FILTERGROUP(0);
        CurrPage.SETSELECTIONFILTER(Rec);
        IF COUNT > 3 THEN BEGIN
            IF NOT CONFIRM(Text002, FALSE, inNewValue, COUNT) THEN BEGIN
                EXIT;
            END;
        END;
        IF FIND('-') THEN
            REPEAT
                Approved := inNewValue;
                MODIFY(FALSE);
            UNTIL NEXT = 0;
        Rec.CLEARMARKS;
        Rec.MARKEDONLY(FALSE);
        FILTERGROUP(2);
        Rec.SETVIEW(txtView2);
        FILTERGROUP(0);
        Rec.SETVIEW(txtView);
        txtView := '';
    end;

    /*procedure SetEmployeeFilter(NewFilter: Code[250])
    begin
        NewEmployeeFilter := NewFilter;
        SettingNewFilters := TRUE;
    end;*/



    /*procedure SetDim1Filter(NewFilter: Code[250])
    begin
        NewDim1Filter := NewFilter;
        SettingNewFilters := TRUE;
    end;

    procedure SetDim2Filter(NewFilter: Code[250])
    begin
        NewDim2Filter := NewFilter;
        SettingNewFilters := TRUE;
    end;*/

    procedure YearOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SetPeriod;
        CurrPage.UPDATE(FALSE);
    end;

    procedure MonthOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SetPeriod;
        CurrPage.UPDATE(FALSE);
    end;

    /*local procedure Dim1FilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SetGlobalDim1;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure Dim2FilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SetGlobalDim2;
        CurrPage.UPDATE(FALSE);
    end;*/

    /*procedure EmployeeFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SetEmployee;
        CurrPage.UPDATE(FALSE);
    end;*/

    /*procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        IF txtView <> '' THEN BEGIN
            CLEARMARKS;
            MARKEDONLY(FALSE);
            //FILTERGROUP(2);
            Rec.SETVIEW(txtView2);
            //FILTERGROUP(0);
            Rec.SETVIEW(txtView);
            txtView := '';
        END;
    end;*/


    /*procedure EmployeeNoOnAfterInput(var Text: Text[1024])
    begin
        recEmployee.RESET;
        recEmployee.SETFILTER("No.", '*' + UPPERCASE(Text) + '*');
        IF recEmployee.COUNT = 1 THEN BEGIN
            recEmployee.FIND('-');
            Text := recEmployee."No.";
        END;
    end;*/

}