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


        field(6; TypeOF; enum "Type of Trainings")
        {
            Caption = 'Vrsta Treninga';
        }
        field(7; Year; Integer)
        {
            Caption = 'Godina';
        }

    }
    keys
    {
        key(Key1; Code)
        {
        }
    }

}