page 50021 "Wage Wizard Step 2"
{
    Caption = 'Wage Wizard  Step 2-Work Hours';
    PageType = Document;
    SourceTable = "Wage Header";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Basic)
            {
                Caption = 'Basic';
                group("Basic information")
                {

                    Caption = 'Basic Inf';

                    field("No."; "No.")
                    {
                    }
                    field("Year Of Wage"; "Year Of Wage")
                    {
                    }
                    field("Month Of Wage"; "Month Of Wage")
                    {
                    }
                    field("Entry No."; "Entry No.")
                    {
                    }
                    field(Description; Description)
                    {
                    }
                    field("Last Calculation In Month"; "Last Calculation In Month")
                    {
                    }
                    field(Status; Status)
                    {
                    }
                    field("Date Of Calculation"; "Date Of Calculation")
                    {
                    }
                    field("Year of Calculation"; "Year of Calculation")
                    {
                    }
                    field("Month of Calculation"; "Month of Calculation")
                    {
                    }
                    field("Closing Date"; "Closing Date")
                    {
                    }
                    field("User ID"; "User ID")
                    {
                    }
                    field("Wage Calculation Type"; "Wage Calculation Type")
                    {
                    }
                }
                group("Wage Part")
                {
                    part(Employees; "Wage Wizard Step 2 Subform Emp")
                    {
                    }
                    part(Absences; "Wage Wizard Step 2 Subform Abs")
                    {
                    }
                }
            }
            group(Parameters)
            {
                Caption = 'Parameters';
                field("Hour Pool"; "Hour Pool")
                {
                }
                field(Transportation; Transportation)
                {
                }
                field(Reduction; Reduction)
                {
                }
                field("Minimum Wage"; "Minimum Wage")
                {
                }
            }
            group(Totals)
            {
                Caption = 'Totals';
                field("Temp Brutto"; "Temp Brutto")
                {
                }
                field("Temp Net Wage"; "Temp Net Wage")
                {
                }
                field("Temp Final Net Wage"; "Temp Final Net Wage")
                {
                }
                field("Temp Add. Tax From Brutto"; "Temp Add. Tax From Brutto")
                {
                }
                field("Temp Add. Tax Over Brutto"; "Temp Add. Tax Over Brutto")
                {
                }
                field("Temp Tax"; "Temp Tax")
                {
                }
                field("Temp Added Tax Per City"; "Temp Added Tax Per City")
                {
                }
                field("Temp Wage Reduction"; "Temp Wage Reduction")
                {
                }
                field("Temp Transport"; "Temp Transport")
                {
                }
                field("Temp Sick Leave-Company"; "Temp Sick Leave-Company")
                {
                }
                field("Temp Sick Leave-Fund"; "Temp Sick Leave-Fund")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Next)
            {
                Image = NextSet;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    Response := CONFIRM(Txt003);
                    IF Response THEN BEGIN
                        ConfirmClose2 := FALSE;
                        //bt01
                        // Rec."No." := '0000000001';
                        // Rec."Entry No." := 0;
                        CODEUNIT.RUN(CODEUNIT::"Wage Precalculation", Rec);
                        //Bt01
                        //Rec.GET('0000000001',Rec."Entry No.");
                        Rec.GET(Rec."No.", Rec."Entry No.");
                        Rec."Step 2" := TRUE;
                        CurrPage.SAVERECORD;
                        IF Reduction THEN BEGIN
                            Step3.SETRECORD(Rec);
                            Step3.RUN
                        END
                        ELSE BEGIN
                            Step4.SETRECORD(Rec);
                            Step4.RUN;
                        END;
                        CurrPage.EDITABLE(FALSE);
                    END;
                end;
            }
            action(Cancel)
            {
                Image = Cancel;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    WPClose.ClosedForm(Rec);
                    CurrPage.CLOSE;
                end;
            }
            action("Show All Employees")
            {
                Image = Employee;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    CurrPage.UPDATE(TRUE);
                    WageSetup.GET;
                    CurrPage.Employees.PAGE.GETRECORD(Employee);
                    Employee.SETRECFILTER;
                    UpdateAbsences(Employee);
                end;
            }
            action("Show All Absences")
            {
                Image = Absence;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    CurrPage.Employees.PAGE.GETRECORD(Employee);
                    CurrPage.Absences.PAGE.FilterMe(Employee."No.", StartDate, EndDate);
                end;
            }
            action("Show This Round")
            {
                Image = Route;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.Employees.PAGE.FilterMeRound;
                end;
            }
            action("Show Selected")
            {
                Image = SelectEntries;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.Employees.PAGE.FilterMe;
                end;
            }
            action(Previous)
            {
                Image = PreviousSet;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    Response := CONFIRM(Txt006);
                    IF Response THEN BEGIN
                        ConfirmClose2 := FALSE;
                        IF Rec."Step 2" THEN BEGIN
                            WageCalcTemp.RESET;
                            WageCalcTemp.SETFILTER("Wage Header No.", Rec."No.");
                            WageCalcTemp.SETRANGE("Entry No.", Rec."Entry No.");
                            IF NOT WageCalcTemp.ISEMPTY THEN
                                WageCalcTemp.DELETEALL(TRUE);
                            ReductionTemp.RESET;
                            ReductionTemp.SETFILTER("Wage Header No.", Rec."No.");
                            IF NOT ReductionTemp.ISEMPTY THEN
                                ReductionTemp.DELETEALL(TRUE);
                            WPClose.ClosedForm(Rec);
                        END;
                        Rec."Step 2" := FALSE;
                        CurrPage.SAVERECORD;
                        Step1.SETRECORD(Rec);
                        Step1.RUN;
                        CurrPage.EDITABLE(FALSE);
                    END;
                end;
            }
            action("Update Hours")
            {
                Image = UnitOfMeasure;
                Promoted = true;
                PromotedIsBig = true;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        IF (Rec."No." <> xRec."No.") OR ("Entry No." <> xRec."Entry No.") THEN BEGIN
            Rec.RESET;
            Rec.GET(RecKey, RecKey2);
        END;
        OnAfterGetCurrRecord;
    end;

    trigger OnClosePage()
    begin
        WPClose.ClosedForm(Rec);
    end;

    trigger OnInit()
    begin
        ConfirmClose2 := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
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

        FILTERGROUP(10);
        //Rec.SETRANGE("No.", Rec."No.");
        Rec.SETRANGE("Entry No.", Rec."Entry No.");
        //bt
        //RecKey:= '0000000001';
        RecKey := Rec."No.";
        RecKey2 := Rec."Entry No.";
        FILTERGROUP(0);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        IF ConfirmClose2 THEN BEGIN
            Response := CONFIRM(Txt001);
            IF Response THEN
                WageHeader.RESET;
            WageHeader.SETFILTER(Status, '0');
            IF WageHeader.FIND('-') THEN
                WageHeader.DELETE;
            EXIT(Response);
        END
        ELSE
            EXIT(TRUE);
    end;

    var
        Employee: Record "Employee";
        WageSetup: Record "Wage Setup";
        WageCalcTemp: Record "Wage Calculation Temp";
        WageHeader: Record "Wage Header";
        ReductionTemp: Record "Reduction per Wage";
        Step1: Page "Wage Wizard Step 1";
        Step3: Page "Wage Wizard Step 3";
        Step4: Page "Wage Wizard Step 4";
        AbsenceFill: Codeunit "Absence Fill";
        StartDate: Date;
        EndDate: Date;
        Response: Boolean;
        ConfirmClose2: Boolean;
        RecKey: Code[10];
        RecKey2: Integer;
        WPClose: Codeunit "Wage Precalculation";
        Txt001: Label 'Da li želite prekinuti obračun plaća?';
        Txt002: Label 'Da li ste sigurni da želite provjeriti preklapanja u periodima?';
        Txt003: Label 'Da li ste sigurni da želite preći na slijedeći korak?';
        Txt004: Label 'Ni jedan zaposlenik nije izabran za ovaj krug obračuna!';
        Txt005: Label 'Obračun prijevoza za ovaj mjesec je već bio izvršen. Da li želite dodati tom obračunu?';
        Txt006: Label 'Da li ste sigurni da se želite vratiti na prethodni korak?';
        Txt007: Label 'Morate unijeti šifru ugovora za djelatnika %1';
        Txt008: Label 'Unazad godinu dana ne postoji radni mjesec za djelatnika %1';
        Err01: Label 'U kalendaru ne postoji %1';
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';

    procedure UpdateAbsences(var EmployeeRec: Record Employee)
    begin
        AbsenceFill.FillAbsence(Rec."Month Of Wage", Rec."Year Of Wage", EmployeeRec);
    end;

    procedure OnAfterGetCurrRecord()
    begin
        //bt01
        xRec := Rec;

        StartDate := AbsenceFill.GetMonthRange(Rec."Month Of Wage", Rec."Year Of Wage", TRUE);
        EndDate := AbsenceFill.GetMonthRange(Rec."Month Of Wage", Rec."Year Of Wage", FALSE);
    end;

    procedure EmployeesOnActivate()
    begin

        CurrPage.Employees.PAGE.SetWCType(Rec."Wage Calculation Type");
        CurrPage.Employees.PAGE.FilterMe;
        CurrPage.Absences.PAGE.RefreshMe;
    end;
}

