page 51130 "Work performance"
//ED 01 START
{
    Caption = 'Work performance';
    DataCaptionFields = "Employee No.";
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Work performance";

    layout
    {

        area(content)
        {
            repeater(s)
            {
                field("Entry No."; "Entry No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Employee No."; "Employee No.")
                {
                    trigger OnValidate()
                    begin
                        Grade := ("Quality of performed work" + "Scope of performed work" + "Deadline for completion of work" + "Attitude towards work obligations" + 4) / 4;
                    end;
                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                }
                field("Last Name"; "Last Name")
                {
                    Editable = false;
                }
                field("Quality of performed work"; "Quality of performed work")
                {
                    Editable = true;
                }
                field("Scope of performed work"; "Scope of performed work")
                {
                    Editable = true;
                }
                field("Deadline for completion of work"; "Deadline for completion of work")
                {
                    Editable = true;
                }
                field("Attitude towards work obligations"; "Attitude towards work obligations")
                {
                    Editable = true;
                }
                field(Grade; Grade)
                {
                    Editable = false;
                }
                field("Increase in basic salary(%)"; "Increase in basic salary(%)")
                {
                    Editable = false;
                }
                field(Approved; Approved)
                {
                    Editable = true;
                }
                /*
                field("Cause of Absence Code"; "Cause of Absence Code")
                {
                    trigger OnValidate()
                    begin
                        CauseOfAbsence.Get("Cause of Absence Code");
                        if CauseOfAbsence."Added To Hour Pool" then
                            EditableHours := true
                        else begin
                            EditableHours := false;
                            Hours := 0;
                        end;
                        
                    end;
                }
                field(Description; Description)
                {

                }
                field(Hours; Hours)
                {
                    Editable = EditableHours;
                    BlankZero = true;
                }
                field(Approved; Approved)
                {
                    Editable = true;
                }*/
            }
        }
    }

    actions
    {
        area(navigation)
        {

            /*action("&Unapprove All")
            {
                Caption = '&Unapprove All';
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+F9';


            }*/
        }
        area(processing)
        {

        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Quality of performed work" := "Quality of performed work"::"3";
        Rec."Scope of performed work" := "Scope of performed work"::"3";
        Rec."Deadline for completion of work" := "Deadline for completion of work"::"3";
        Rec."Attitude towards work obligations" := "Attitude towards work obligations"::"3";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        /*IF "Cause of Absence Code" = '' then
            Error(Text007);

        CauseOfAbsence.Get("Cause of Absence Code");
        if CauseOfAbsence."Added To Hour Pool" then
            if Hours = 0 then
                Error(Text008);*/
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Grade := ("Quality of performed work" + "Scope of performed work" + "Deadline for completion of work" + "Attitude towards work obligations" + 4) / 4;
        /*IF "From Date" = 0D then
            Error(Text001);

        IF "To Date" = 0D then
            ERROR(Text004);*/
    end;

    var
        Employee: Record "Employee";
        WageSetup: Record "Wage Setup";
        EditableHours: Boolean;
        EmployeeAbsenceReg: Record "Employee Absence Reg";
        recEmplAbsence: Record "Employee Absence";
        recEmplAbsenceTemp: Record "Employee Absence" temporary;
        Text001: Label 'Set filters do not allow entry';
        Text004: Label 'Ending Date field cannot be blank.';
        Text007: Label 'Cause of Absence Code field cannot be blank.';
        Text008: Label 'Hours field cannot be blank.';
        CauseOfAbsence: Record "Cause of Absence";
    //ED 01 END
}