pageextension 50119 Employee_Qualifications_HR extends "Employee Qualifications"
{




    layout
    {

        modify("Qualification Code")
        {
            visible = visibleQualification;
        }
        modify(Description)
        {
            visible = visibleQualification;
        }

        addafter("Course Grade")
        {
            field("Computer Knowledge Code"; "Computer Knowledge Code")
            {
                Visible = visibleComputer;
            }
            field("Computer Knowledge Description"; "Computer Knowledge Description")
            {
                visible = visibleComputer;
            }
            field("Language Code"; "Language Code")
            {
                Visible = visibleLanguage;
            }
            field("Language Level"; "Language Level")
            {
                Visible = visibleLanguage;
            }
            field("Language Name"; "Language Name")
            {
                Visible = visibleLanguage;
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




