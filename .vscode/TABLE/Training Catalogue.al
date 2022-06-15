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
            OptionMembers = " ",Interni,Eksterni;
            Caption = 'Type';

        }

        field(5; Month; enum Month)
        {
            Caption = 'Month';
        }


        field(6; TypeOF; Code[20])
        {
            Caption = 'Vrsta Treninga';
            TableRelation = "Training Type";
            trigger OnValidate()
            var
                Training: record "Training Type";
            begin
                Training.Reset();
                Training.SetFilter(Code, '%1', TypeOF);
                if Training.FindFirst() then begin
                    "Type of name" := Training.Description;
                end
                else begin
                    "Type of name" := '';
                end;
            end;


        }

        field(7; Year; Integer)
        {
            Caption = 'Godina';
        }
        field(8; "Type of name"; text[250])
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