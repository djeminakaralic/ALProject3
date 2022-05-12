pageextension 50119 Employee_Qualifications_HR extends "Employee Qualifications"
{
    layout
    { }

    trigger OnOpenPage()
    var
        myInt: Integer;
        Filter: Text;
        Filter1: Text;
        Filter2: Text;
        visibleQualification: Boolean;
        visibleLanguage: Boolean;
        visibleComputer: Boolean;
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




}



