page 50213 Employee_Qualifications_HR
{

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Employee Qualification";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {

                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;

                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = all;

                }

                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Computer Knowledge Code"; "Computer Knowledge Code")
                {
                    ApplicationArea = all;
                    Visible = visibleComputer;

                }
                field("Computer Knowledge Description"; "Computer Knowledge Description")
                {
                    ApplicationArea = all;
                    Visible = visibleComputer;
                }
                field("Language Code"; "Language Code")
                {
                    ApplicationArea = all;
                    Visible = visibleLanguage;
                }
                field("Language Name"; "Language Name")
                {
                    ApplicationArea = all;
                    Visible = visibleLanguage;
                }
                field("Language Level"; "Language Level")
                {
                    ApplicationArea = all;
                    Visible = visibleLanguage;
                }
                field("Qualification Code"; "Qualification Code")
                {
                    ApplicationArea = all;
                    Visible = visibleQualification;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    Visible = visibleQualification;
                }
                field("Institution/Company"; "Institution/Company")
                {
                    ApplicationArea = all;
                }
                field("Decision No."; "Decision No.")
                {
                    ApplicationArea = all;
                }
                field("Exam Passed"; "Exam Passed")
                {
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = all;
                }
                field("Evidence of certification"; "Evidence of certification")
                {
                    ApplicationArea = all;
                }
                field("Expiration Date"; "Expiration Date")
                {

                }
                field(Comment; Comment)
                {
                    ApplicationArea = all;
                }
                field("Sector Description"; "Sector Description")
                {
                    ApplicationArea = all;
                }
                field("Department Category"; "Department Category")
                {
                    ApplicationArea = all;
                }
                field("Group Description"; "Group Description")
                {
                    ApplicationArea = all;
                }
                field(Position; Position)
                {
                    ApplicationArea = all;
                }
            }


        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }


    trigger OnOpenPage()

    begin
        Filter := Rec.GETFILTER("Qualification Code");
        Filter1 := Rec.GETFILTER("Computer Knowledge Code");
        Filter2 := Rec.GETFILTER("Language Code");
        IF (Filter <> '') THEN BEGIN
            visibleQualification := TRUE;
            visibleComputer := FALSE;
            visibleLanguage := FALSE;
        END
        ELSE
            IF (Filter1 <> '') THEN BEGIN
                visibleQualification := FALSE;
                visibleComputer := TRUE;
                visibleLanguage := FALSE;
            END
            ELSE
                IF (Filter2 <> '') THEN BEGIN
                    visibleQualification := FALSE;
                    visibleComputer := FALSE;
                    visibleLanguage := TRUE;
                END
                ELSE BEGIN
                    visibleQualification := TRUE;
                    visibleComputer := TRUE;
                    visibleLanguage := TRUE;
                END;

    end;

    var
        myInt: Integer;
        Filter: Text;
        Filter1: Text;
        Filter2: Text;
        visibleQualification: Boolean;
        visibleLanguage: Boolean;
        visibleComputer: Boolean;


}




