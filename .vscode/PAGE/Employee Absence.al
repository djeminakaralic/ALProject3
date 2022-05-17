page 51129 "Employee Absence"
{
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
                field("Entry No."; "Entry No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Employee No."; "Employee No.")
                {

                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                }
                field("Last Name"; "Last Name")
                {
                    Editable = false;
                }
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
                    Rec.FINDFIRST;
                    BEGIN
                        IF Rec."Approved" = FALSE THEN BEGIN
                            REPEAT
                                Validate(Rec."Approved", TRUE);
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0;
                        END
                        /*ELSE BEGIN
                            REPEAT
                                Rec."Approved" := FALSE;
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0
                        END;*/
                    END;
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
                    Rec.FINDFIRST;
                    BEGIN
                        IF Rec."Approved" = TRUE THEN BEGIN
                            REPEAT
                                Validate(Rec."Approved", FALSE);
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0;
                        END
                        /*ELSE BEGIN
                            REPEAT
                                Rec."Approved" := TRUE;
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0
                        END;*/
                    END;
                end;
            }

            //}
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

            
           


            /*action("&Edit")
            {
                Caption = '&Edit';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    SetEditable(NOT CurrPage.EDITABLE);
                end;
            }*/
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF "Cause of Absence Code" = '' then
            Error(Text007);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF "From Date" = 0D then
            Error(Text001);

        IF "To Date" = 0D then
            ERROR(Text004);
    end;

    var
        Text004: Label 'Ending Date field cannot be blank.';
        Text007: Label 'Cause of Absence Code field cannot be blank.';
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

}