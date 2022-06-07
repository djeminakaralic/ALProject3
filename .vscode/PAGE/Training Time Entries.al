page 50067 "Training Time Entries"
{


    Caption = 'Evidencija održavanja treninga/edukacija';
    PageType = List;
    SourceTable = "Training Time Entry";


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Code; Code)
                {

                }
                field(Code2; Code2)
                {

                }
                field(Type; Type)
                {

                }
                field(Location; Location) { }
                field(Month; Month) { }
                field("Start date"; "Start date") { }
                field("End date"; "End date") { }
                field(Status; Status) { }
                field("Number of people"; "Number of people") { }
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


