table 50033 "Training Catalogue"
{
    Caption = 'Katalog treninga';
    LookupPageId = "Trainings Catalogue";
    DrillDownPageId = "Trainings Catalogue";

    fields
    {
        field(1; Code; Integer)
        {
            AutoIncrement = true;
            Caption = 'Code';

        }
        field(2; Name; Text[250])
        {
            Caption = 'Name';

        }
        field(3; Type; Option)
        {
            OptionMembers = Interni,Eksterni;
            Caption = 'Type';

        }
        field(4; Location; Text[250])
        {
            Caption = 'Location';

        }
        field(5; Month; Text[50])
        {
            Caption = 'Month';
        }


        field(6; TypeOF; Code[20])
        {
            Caption = 'Vrsta Treninga';
            TableRelation = "Training Type";
            trigger OnValidate()
            var
                TrainingType: record "Training Type";
            begin
                TrainingType.Reset();

                TrainingType.SetFilter(Code, '%1', TypeOF);
                if TrainingType.FindFirst() then begin
                    "Type of training name" := TrainingType.Description;
                end else begin
                    "Type of training name" := '';
                end;
            end;


        }
        field(7; Year; Integer)
        {
            Caption = 'Godina';
        }
        field(8; "Type of training name"; Text[250])
        {
            Caption = 'Naziv vrste treninga';
        }


    }
    keys
    {
        key(Key1; Code)
        {
        }
    }

}