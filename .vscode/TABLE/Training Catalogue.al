table 50033 "Training Catalogue"
{
    Caption = 'Katalog treninga';

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
        field(6; "Travel cost ino"; Decimal)
        {

        }
        field(7; "Travel cost home"; Decimal)
        {

        }
        field(8; "Daily rate home"; Decimal)
        {

        }
        field(9; "Daily rate ino"; Decimal)
        {

        }
        field(10; "Number of days"; Integer)
        {

        }
        field(11; "Daily rate home SUM"; Decimal)
        {
            trigger OnValidate()
            begin
                "Daily rate home SUM" := "Daily rate home" * "Number of days";
            end;

        }
        field(12; "Daily rate ino SUM"; Decimal)
        {
            trigger OnValidate()
            begin
                "Daily rate ino SUM" := "Daily rate ino" * "Number of days";
            end;

        }
        field(13; "Kotizacija"; Decimal)
        {

        }
        field(14; "Hours"; Integer)
        {

        }
    }
    keys
    {
        key(Key1; Code)
        {
        }
    }

}