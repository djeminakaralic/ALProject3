table 50085 "HR Cue"
{


    fields
    {

        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Key';


        }
        field(2; Employees; Integer)
        {
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER(Active | Inactive | Unpaid | Terminated | "On boarding")));
            Caption = 'Employees';
            Editable = false;
            FieldClass = FlowField;
        }

        field(4; "Active Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER('Active'),
                                                "Potential Employee" = CONST(false),
                                                "Associates" = Const(FALSE)));
            Caption = 'Active Employees';

        }

        field(21; "Responsibility Center Filter"; Code[10])
        {
            Caption = 'Responsibility Center Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(50001; "Inactive Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER(Inactive),
                                                "Potential Employee" = CONST(false)));
            Caption = 'Inactive Employees';

        }
        field(50002; "Potential Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Potential Employee" = CONST(true)));
            Caption = 'Potential Employees';

        }
        field(50003; "Invited to Interview"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Potential Employee" = CONST(true),
                                                "Invited to interview" = CONST(true)));
            Caption = 'Invited to Interview';

        }
        field(50004; "Appropriate Candidates"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Potential Employee" = CONST(true),
                                                "Appropriate candidate" = CONST(true)));
            Caption = 'Appropriate Candidates';

        }
        field(50005; "Inappropriate Candidates"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Potential Employee" = CONST(true),
                                                "Inappropriate candidate" = CONST(true)));
            Caption = 'Inappropriate Candidates';

        }

        field(50007; "Employees on Probation"; Integer)
        {
            CalcFormula = Count("Employee Contract Ledger" WHERE("Testing Period" = FILTER(TRUE),
                                                                  Active = FILTER(TRUE)));
            Caption = 'Employees on Probation';
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //t_Employee.FINDFIRST;
                //t_Employee.SETRANGE("Probation Period End",TODAY,010101D);
            end;
        }
        field(50008; "Probation expired"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Is not extended expired P" = FILTER(TRUE),
                                                                 "Testing Period Ending Date" = FIELD(DateFilter2),
                                                                  "Show Record" = FILTER(TRUE)));
            Caption = 'Probation expired';


            trigger OnLookup()
            begin


                //datum:=CALCDATE('<',TODAY);
                //t_Employee.FINDFIRST;
                //t_Employee.SETRANGE("Probation Period End",TODAY,311299D);
            end;
        }
        field(50094; DateTraining; Date)
        {
            FieldClass = FlowFilter;
        }

        field(50010; "Inactive - Terminated"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER(Terminated),
                                                "Potential Employee" = CONST(false)));
            Caption = 'Inactive - Terminated';

        }
        field(50011; DateFIlter; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50012; DateFilter2; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50013; "Probation Expires in NextPerio"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Testing Period Ending Date" = FIELD(DateFIlter),
                                                                  Active = FILTER(TRUE),
                                                                  "Is not extended P" = FILTER(TRUE)));
            Caption = 'Probation expired';


            trigger OnLookup()
            begin

                HRsetup.GET;
                datum := CALCDATE(HRsetup."Probation Expire Days", TODAY);
                t_Employee.FINDFIRST;
                //t_Employee.SETRANGE("Probation Period End",datum,TODAY);
            end;
        }
        field(50014; DateFilter3; Date)
        {
            FieldClass = FlowFilter;
        }


        field(50018; "Three Years In Company"; Integer)
        {
            CalcFormula = Count("Employee Contract Ledger" WHERE("Three Years in company" = FILTER(TRUE),
                                                                  "Grounds for Term. Code" = FILTER(''),
                                                                  "Show Record" = FILTER(TRUE)));
            FieldClass = FlowField;

            trigger OnLookup()
            begin
                /*HRsetup.GET;
                finalDate:= CALCDATE('-3Y',CALCDATE(HRsetup.WarningPeriod,TODAY));
                
                ECL.FINDFIRST;
                ECL.SETRANGE(Status,0);
                
                ECL.SETRANGE("Starting Date",CALCDATE('-3Y',TODAY),CALCDATE('-3Y',finalDate));*/

            end;
        }
        field(50019; DateFilter4; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50020; DateFilter5; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50021; "New Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER(Active),
                                                "Potential Employee" = CONST(false),
                                                Associates = CONST(false),
                                                "Employment Date" = FIELD(DateFilter5)));
            Caption = 'New Employees';

        }
        field(50022; DateFilterTraining; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50023; Practicians; Integer)
        {
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER(Practicians)));
            Caption = 'Practicians';
            FieldClass = FlowField;
        }
        field(50024; "For Calculation"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("For Calculation" = FILTER(TRUE)));
            Caption = 'For Calculation';

        }
        field(50025; DateFilter6; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50026; "New Employees FC"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Starting Date" = FIELD(DateFilter6),
                                                                  "Reason for Change" = FILTER("New Contract"),
                                                                  "Show Record" = FILTER(TRUE)));
            Caption = 'New Employees';

        }
        field(50027; "Terminated Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Ending Date" = FIELD(DateFilter7),
                                                                  "Grounds for Term. Code" = FILTER(<> ''),
                                                                  "Show Record" = FILTER(TRUE)));
            Caption = 'Terminated Employees';

        }
        field(50028; Transfers; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Reason for Change" = FILTER("Position Change" | "Workplace Change" | "Organizational Changes 1" | "Organizational Changes 2" | "Organizational Changes 3" | "Organizational Changes 4" | "Workplace And Wage Change" | "Position Location And Wage Change"),
                                                                  Active = FILTER(TRUE),
                                                                  "Starting Date" = FIELD(DateFilter6)));
            Caption = 'Transfers';

        }
        field(50029; "Surname Change"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Surname" WHERE("Last Date Modified" = FIELD(DateFilter6),
                                                          "Number Of Surnames" = FILTER(> 1),
                                                          "No." = FILTER('<> "9*"')));
            Caption = 'Surname Change';

        }
        field(50030; "Adress Change"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Alternative Address" WHERE("Date From (CIPS)" = FIELD(DateFilter6),
                                                             Active = FILTER(TRUE),
                                                             "Employment Date" = FIELD(DateFilter8)));
            Caption = 'Adress Change';

        }
        field(50031; "Internal Fund"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Internal Solidarity Fund" = FILTER(TRUE),
                                                "Int. Solidarity Fund Date From" = FIELD(DateFilter6)));


        }
        field(50032; "External Fund"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("External Solidarity Fund" = FILTER(TRUE),
                                               "Ext. Solidarity Fund Date From" = FIELD(DateFilter6)));
            Caption = 'External Fund';

        }
        field(50033; "Education Level Change"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Additional Education" WHERE(Active = FILTER(TRUE),
                                                              "From Date" = FIELD(DateFilter6),
                                                              "Employment Date" = FIELD(DateFilter8)));
            Caption = 'Education Level Change';

        }
        field(50034; Calculated; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Wage Calculation" WHERE("Wage Calculation Type" = FILTER(Regular),
                                                          "Date Of Calculation" = FIELD(DateFilter6)));
            Caption = 'Calculated';

        }
        field(50035; "Terminated  Unpaid Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER(Unpaid)));
            Caption = 'Terminated Employees';

        }
        field(50036; DateFilter7; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50037; DateFilter8; Date)
        {
            FieldClass = FlowFilter;
        }

        field(50039; "Unsegmented Positions"; Integer)
        {
            CalcFormula = Count("Employee Contract Ledger" WHERE("Contract Type" = FILTER(<> 7),
                                                                  "Starting Date" = FILTER('')));
            Caption = 'Unsegmented Positions';
            FieldClass = FlowField;

            trigger OnLookup()
            begin
                OrgShema.SETFILTER(Status, '%1', OrgShema.Status::Blocked);
                IF OrgShema.FINDLAST THEN BEGIN
                    OrgShema.GET;
                    "Active Sistematizaction" := OrgShema.Code;
                END;
            end;
        }
        field(50040; "Education And Development"; Integer)
        {
            CalcFormula = Count(Employee WHERE("Education Plan" = FILTER("In Progress" | Completed)));
            Caption = 'Education And Development';
            FieldClass = FlowField;
        }
        field(50093; "Training"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Training Ledger");
            Caption = 'Trainings';

        }

        field(50041; "Wage Change"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Starting Date" = FIELD(DateFilter9),
                                                                  "Wage Change" = FILTER("Increase-Additional Responsibility" | "Increase-Replacement" | "Increase-Additional Work Effort" | "Increase-Promotion" | "Increase-Wage After Disciplinary Measure" | "Increase-Reconcilliation" | "Increase-Position Change" | "Increase-Check" | "Decrease-Responsibility Decrease" | "Decrease-Inadequate Performance" | "Decrease-Disciplinary Measure" | "Decrease-Rellocation" | "Decrease-Reconcilliation"),
                                                                  "Show Record" = FILTER(TRUE)));
            Caption = 'Wage Change';

        }
        field(50042; DateFilter9; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50043; "Expiring Contracts"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Ending Date" = FIELD(DateFilter10),
                                                                  Active = FILTER(TRUE),
                                                                  "Grounds for Term. Code" = FILTER(''),
                                                                  "Is not extended" = FILTER(TRUE),
                                                                  "Show Record" = FILTER(TRUE)));
            Caption = 'Expiring Contracts';

        }
        field(50044; DateFilter10; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50045; "Expired Contracts"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Ending Date" = FIELD(DateFilter11),
                                                                  "Grounds for Term. Code" = FILTER(''),
                                                                  "Is not extended expired" = FILTER(TRUE),
                                                                  "Show Record" = FILTER(TRUE)));
            Caption = 'Expiring Contracts';

        }
        field(50046; DateFilter11; Date)
        {
            FieldClass = FlowFilter;
        }

        field(50048; "On Boarding"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER("On boarding")));
            Caption = 'On Boarding';

        }
        field(50049; "Temporary Disposition"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Temporary disposition" = FILTER(TRUE),
                                                                  Status = FILTER(Active),
                                                                  "Show Record" = FILTER(TRUE),
                                                                  Active = FILTER(TRUE)));
            Caption = 'Temporary Disposition';

        }
        field(50050; "Sent Notification"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Notification send" = FILTER(TRUE),
                                                                  Status = FILTER(Active),
                                                                  "Ending Date" = FIELD(DateFilter10),
                                                                  "Grounds for Term. Code" = FILTER(''),
                                                                  "Show Record" = FILTER(TRUE)));
            Caption = 'Sent Notification';

        }
        field(50051; "Not Sent Notification"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Notification send" = FILTER(FALSE),
                                                                  Status = FILTER(Active),
                                                                  "Ending Date" = FIELD(DateFilter10),
                                                                  "Grounds for Term. Code" = FILTER(''),
                                                                  "Show Record" = FILTER(TRUE)));
            Caption = 'Not Sent Notification';

        }
        field(50052; "Active Sistematizaction"; Code[10])
        {
            Caption = 'Active Sistematizaction';
            FieldClass = FlowFilter;
        }
        field(50053; "Union Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Union Employees" WHERE("Date From" = FIELD(DateFilter6)));
            Caption = 'Union Employees';

        }



        field(50057; "Temporary Contract"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER("Temporary Contract"),
                                                "External employer Status" = FILTER(Active)));
            Caption = 'Temporary Contract';

        }
        field(50058; Volonteer; Integer)
        {
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER(Volonteer),
                                                "External employer Status" = FILTER(Active)));
            Caption = 'Volonteer';
            FieldClass = FlowField;
        }


        field(50061; "Contract in conflict"; Integer)
        {
            CalcFormula = Count("Employee Contract Ledger" WHERE(Conflict = FILTER(TRUE),
                                                                  "The Change is update" = FILTER(FALSE)));
            Caption = 'Contract in conflict';
            FieldClass = FlowField;
        }
        field(50062; DateFilter12; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50063; Candidate; Integer)
        {
            CalcFormula = Count(Candidates);
            Caption = 'Candidates';
            FieldClass = FlowField;
        }
        field(50064; "Active Measures"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Work Duties Violation" WHERE("Page Type" = FILTER("Disciplinary measures"),
                                                               "Active Measure" = FILTER(TRUE)));
            Caption = 'Active Measures';

        }
        field(50065; "Expirings Measures"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Work Duties Violation" WHERE("Page Type" = FILTER("Disciplinary measures"),
                                                               "Measure To" = FIELD("Expirings Measures Filter")));
            Caption = 'Expirings Measures';

        }
        field(50066; "Expirings Measures Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50067; OpenPostingAll; Integer)
        {
            CalcFormula = Count(Posting WHERE("Published Date" = FILTER(<> ''),
                                               "Employment Date" = FILTER(''),
                                               "Closing Date" = FILTER(<> ''),
                                               Status = FILTER('Otvoren')));
            Caption = 'OpenPostingAll';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50068; OpenPostingInternal; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Posting WHERE("Published Date" = FILTER(<> ''),
                                               "Employment Date" = FILTER(''),
                                               "HR Posting No." = FILTER('@*IN*')));
            Caption = 'OpenPostingInternal';
            Editable = false;

        }
        field(50069; OpenPostingExternal; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Posting WHERE("Published Date" = FILTER(<> ''),
                                               "Employment Date" = FILTER(''),
                                               "HR Posting No." = FILTER('@*EK*')));
            Caption = 'OpenPostingExternal';
            Editable = false;

        }
        field(50070; OpenPostingBase; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Posting WHERE("Published Date" = FILTER(<> ''),
                                               "Employment Date" = FILTER(''),
                                               "HR Posting No." = FILTER('@*BP*')));
            Caption = 'OpenPostingBase';
            Editable = false;

        }
        field(50071; ClosedPostingCompleted; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Posting WHERE(Status = FILTER('Izbor završen')));
            Caption = 'ClosedPostingCompleted';
            Editable = false;

        }
        field(50072; ClosedPostingNoChoice; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Posting WHERE(Status = FILTER('Bez izbora')));
            Caption = 'ClosedPostingNoChoice';
            Editable = false;

        }
        field(50073; ClosedPosting; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Posting WHERE(Status = FILTER('Zatvoren')));
            Caption = 'ClosedPosting';
            Editable = false;

        }
        field(50074; CandidatesGFSarajevo; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Candidates WHERE(Location = FILTER('Ilijaš|Sarajevo|Ilidža|Hrasnica|Istočno Novo Sarajevo|Hadžići|Pale|Goražde')));
            Caption = 'Candidates GF Sarajevo';
            Editable = false;

        }
        field(50075; CandidatesGFZenica; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Candidates WHERE(Location = FILTER('Zenica|Zavidovići|Žepče|Kakanj|Vitez|Kiseljak|Visoko|Tešanj|Maglaj|Jelah|Teslić|Travnk|Bugojno')));
            Caption = 'Candidates GF Zenica';
            Editable = false;

        }
        field(50076; CandidatesGFBanjaLuka; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Candidates WHERE(Location = FILTER('Banja Luka|Laktaši|Mrkonjić Grad|Kotor Varoš|Prijedor|Kozarska Dubica|Novi Grad|Gradiška|Prnjavor|Doboj|Derventa|Modrića|Brod|Šamac')));
            Caption = 'Candidates GF BanjaLuka';
            Editable = false;

        }
        field(50077; CandidatesGFMostar; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Candidates WHERE(Location = FILTER('Mostar|Konjic|Čitljuk|Čapljina|Međugorje|Široki Brijeg|Grude|Ljubuški|Posušje|Trebinje|Livno|Tomislagrad')));
            Caption = 'Candidates GF Mostar';
            Editable = false;

        }
        field(50078; CandidatesGFTuzla; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Candidates WHERE(Location = FILTER('Tuzla|Živinice|Lukavac|Banovići|Gračanica|Gradačac|Srebrenik|Bijeljina|Ugljevik|Brčko|Orašje|Odžak')));
            Caption = 'Candidates GF Tuzla';
            Editable = false;

        }
        field(50079; CandidatesGFBihac; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Candidates WHERE(Location = FILTER('Bihać|Cazin|Velika Kladuša|Sanski Most|Ključ|Bosanska Krupa|Bužim')));
            Caption = 'Candidates GF Bihac';

        }
        field(50080; EconomicProfileLastYear; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Candidates WHERE("Date of aplication" = FIELD(LastYearFilter),
                                                  "Name of edu. institution" = FILTER('@*Ekonomski fakultet*')));
            Caption = 'Economic Profile Last Year';
            Editable = false;

        }
        field(50081; EconomicProfileThisYear; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Candidates WHERE("Date of aplication" = FIELD(ThisYearFilter),
                                                  "Name of edu. institution" = FILTER('@*Ekonomski fakultet*')));
            Caption = 'Economic Profile This Year';
            Editable = false;

        }
        field(50082; LawFacultyLastYear; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Candidates WHERE("Date of aplication" = FIELD(LastYearFilter),
                                                  "Name of edu. institution" = FILTER('@*Pravni fakultet*')));
            Caption = 'LawFacultyLastYear';

        }
        field(50083; LawFacultyThisYear; Integer)
        {

            FieldClass = FlowField;
            CalcFormula = Count(Candidates WHERE("Date of aplication" = FIELD(ThisYearFilter),
                                                  "Name of edu. institution" = FILTER('@*Pravni fakultet*')));
            Caption = 'LawFacultyThisYear';

        }
        field(50084; ElectricalLastYear; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Candidates WHERE("Date of aplication" = FIELD(LastYearFilter),
                                                  "Name of edu. institution" = FILTER('@*elektrotehni*')));
            Caption = 'ElectricalLastYear';

        }
        field(50085; ElectricalThisYear; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Candidates WHERE("Date of aplication" = FIELD(ThisYearFilter),
                                                  "Name of edu. institution" = FILTER('@*elektrotehni*')));
            Caption = 'ElectricalThisYear';

        }
        field(50086; LastYearFilter; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50087; ThisYearFilter; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50088; TodayFilter; Date)
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    var
        datum: Date;
        t_Employee: Record "Employee";
        ECL: Record "Employee Contract Ledger";
        datum2: Date;
        HRsetup: Record "Human Resources Setup";
        finalDate: Date;
        datum3: Date;

        OrgShema: Record "Org Shema";
        Sistematizacija: Text;

    procedure SetRespCenterFilter()
    var
        UserSetupMgt: Codeunit "User Setup Management";
        RespCenterCode: Code[10];
    begin
        RespCenterCode := UserSetupMgt.GetPurchasesFilter;
        IF RespCenterCode <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center Filter", RespCenterCode);
            FILTERGROUP(0);
        END;
    end;
}

