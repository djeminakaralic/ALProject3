table 50088 "Segmentation Data 2"
{
    Caption = 'Segmentation Data';

    fields
    {
        field(1; "Position No."; Code[20])
        {
            Caption = 'Position No.';
            NotBlank = true;
            TableRelation = Position;
        }
        field(2; "Segmentation Code"; Code[30])
        {
            Caption = 'Segmentation Code';
            NotBlank = true;
            TableRelation = "Quality Measure";

            trigger OnValidate()
            begin
                Confidential.GET("Segmentation Code");
                Description := Confidential.Description;
            end;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            NotBlank = true;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(5; Coefficient; Decimal)
        {
            Caption = 'Coefficient';
            Editable = true;
        }
        field(50000; "Segmentation Name"; Code[250])
        {
            Caption = 'Segmentation Name';
            //ĐKTableRelation = Position.Field50007 WHERE (Code=FIELD("Position No.""));
            //This property is currently not supported
            //TestTableRelation = false;
            //  ValidateTableRelation = false;
        }
        field(50001; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                /*IF "Ending Date"<>0D THEN BEGIN
                  IF "Starting Date"=0D THEN
                    ERROR(Text000);
                  IF "Ending Date"<"Starting Date" THEN
                      ERROR(Text001);
                    END;*/

                /*IF Active=TRUE THEN BEGIN
                Employee.RESET;
                Employee.SETFILTER("No.","Employee No.");
                IF Employee.FINDFIRST THEN BEGIN
                  Employee."Employment Date":="Starting Date";
                  Employee.MODIFY;
                END;
                
                END;*/

                /*ECL.SETFILTER( "Employee No.","Employee No.");
                      IF ECL.FINDLAST THEN BEGIN
                      Emp.RESET;
                      Emp.SETFILTER("No.","Employee No.");
                      IF Emp.FINDFIRST() THEN
                       BEGIN
                        Emp."Employment Date":="Starting Date";
                        Emp.MODIFY;
                       END;
                      END;*/

            end;
        }
        field(50002; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin
                /*
                IF "Ending Date"<>0D THEN BEGIN
                  IF "Starting Date"=0D THEN
                    ERROR(Text000);
                  IF "Ending Date"<"Starting Date" THEN
                      ERROR(Text001);
                    END;
                
                
                 */

            end;
        }
        field(50006; "Management Level"; Enum "Management Level")
        {
            Caption = 'Management Level';

        }
    }

    keys

    {
        key(Key1; "Position No.", "Segmentation Code", "Line No.", "Segmentation Name", "Starting Date", "Ending Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label 'You can not delete confidential information if there are comments associated with it.';
        Confidential: Record "Quality Measure";
}

