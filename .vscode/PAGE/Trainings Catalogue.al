page 50058 "Trainings Catalogue"
{

    Caption = 'Katalog treninga';
    PageType = List;
    SourceTable = "Training Catalogue";


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Code; Code)
                {

                }
                field(Type; Type)
                {

                }
                field(Location; Location) { }
                field(Month; Month) { }
                field("Travel cost home"; "Travel cost home") { }
                field("Travel cost ino"; "Travel cost ino") { }
                field("Daily rate home"; "Daily rate home")
                {
                    trigger OnValidate()
                    begin
                        "Daily rate home SUM" := "Daily rate home" * "Number of days";
                    end;
                }
                field("Daily rate ino"; "Daily rate ino")
                {
                    trigger OnValidate()
                    begin
                        "Daily rate ino SUM" := "Daily rate ino" * "Number of days";
                    end;
                }
                field("Number of days"; "Number of days")
                {
                    trigger OnValidate()
                    begin
                        "Daily rate home SUM" := "Daily rate home" * "Number of days";
                        "Daily rate ino SUM" := "Daily rate ino" * "Number of days";
                    end;
                }
                field("Daily rate home SUM"; "Daily rate home SUM") { }
                field("Daily rate ino SUM"; "Daily rate ino SUM") { }
                field(Kotizacija; Kotizacija) { }
                field(Hours; Hours) { }


            }
        }


    }
}