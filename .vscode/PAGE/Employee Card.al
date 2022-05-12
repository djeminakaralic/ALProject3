pageextension 50129 EmployeeCard extends "Employee Card"
{


    layout
    {


        modify(Payments)
        {
            Visible = false;
        }
        modify("Employment Date")
        {
            visible = false;
        }
        modify("Search Name")
        {
            Visible = false;
        }
        modify("Privacy Blocked")
        {
            Visible = false;
        }

        modify("Middle Name")
        {
            Visible = false;
        }
        modify(Initials)
        {
            Visible = false;
        }
        modify("Job Title")
        {
            Visible = false;
        }
        modify("Status")
        {
            Visible = false;
        }


        addafter(Personal)
        {

            /* group("Work Experience")
             {

                 Caption = 'Work Experience';
                 //The GridLayout property is only supported on controls of type Grid
                 grid("Work Experience ")
                 {

                     GridLayout = Rows;

                     Group("Total experience")

                     {
                         Caption = 'Total experience';

                         field("Years of Experience"; "Years of Experience")
                         {
                             Editable = false;
                         }
                         field("Months of Experience"; "Months of Experience")
                         {
                             Editable = false;
                         }
                         field("Days of Experience"; "Days of Experience")
                         {
                             Editable = false;
                         }

                     }
                     group("Brought experience")
                     {



                         Caption = 'Brought experience';




                         field("Brought Years of Experience"; "Brought Years of Experience")
                         {
                             Editable = false;
                         }
                         field("Brought Months of Experience"; "Brought Months of Experience")
                         {
                             Editable = false;
                         }
                         field("Brought Days of Experience"; "Brought Days of Experience")
                         {
                             Editable = false;
                         }
                     }

                     group("Experience in Company")
                     {
                         Caption = 'Experience in Company';

                         field("Years of Experience in Company"; "Years of Experience in Company")
                         {
                             Editable = false;
                         }
                         field("Months of Exp. in Company"; "Months of Exp. in Company")
                         {
                             Editable = false;
                         }
                         field("Days of Experience in Company"; "Days of Experience in Company")
                         {
                             Editable = false;
                         }

                     }
                 }



             }
             group("MILITARY EXPERIENCE")
             {

                 Caption = 'Military Experience';
                 //BH 01 start
                 grid("Experience with military")
                 {
                     GridLayout = Rows;
                     group("Work experience with military")
                     {



                         Caption = 'Work experience with military';

                         field("Years with military"; "Years with military")
                         {
                             Editable = false;
                         }
                         field("Months with military"; "Months with military")
                         {
                             Editable = false;
                         }
                         field("Days with military"; "Days with military")
                         {
                             Editable = false;
                         }
                     }
                     group("Military service")
                     {



                         Caption = 'Military service';

                         field("Military Years of Service"; "Military Years of Service")
                         {
                             Editable = false;
                         }
                         field("Military Months of Service"; "Military Months of Service")
                         {
                             Editable = false;
                         }
                         field("Military Days of Service"; "Military Days of Service")
                         {
                             Editable = false;
                         }
                     }


                 }
                 //BH 01 end

             }
             group("ADDED")
             {

                 Caption = 'Added';
                 //BH 01 start
                 grid("Added ")
                 {
                     GridLayout = Rows;
                     group("Brought Years in Company")
                     {



                         Caption = 'Brought Years in Curr. Company';

                         field("Brought Years of Exp. in Curr."; "Brought Years of Exp. in Curr.")
                         {
                             Editable = false;
                         }
                         field("Brought Months of Exp. in Curr."; "Brought Months of Exp.in Curr.")
                         {
                             Editable = false;
                         }
                         field("Brought Days of Exp. in Curr."; "Brought Days of Exp.in Curr.")
                         {
                             Editable = false;
                         }
                     }
                     group("Brought Total")
                     {



                         Caption = 'Brought Total';

                         field("Brought Years Total"; "Brought Years Total")
                         {
                             Editable = false;
                         }
                         field("Brought Months Total"; "Brought Months Total")
                         {
                             Editable = false;
                         }
                         field("Brought Days Total"; "Brought Days Total")
                         {
                             Editable = false;
                         }
                     }


                 }
                 //BH 01 end

             }
 */
            group("Brought experience ")
            {

                Caption = 'Brought experience';
                //The GridLayout property is only supported on controls of type Grid
                grid("Brought experience  ")
                {

                    GridLayout = Rows;
                    group("Brought experience   ")
                    {



                        Caption = 'Brought experience';




                        field("Brought Years of Experience"; "Brought Years of Experience")
                        {
                            Editable = false;
                            Caption = 'Brought Years Card';
                        }
                        field("Brought Months of Experience"; "Brought Months of Experience")
                        {
                            Editable = false;
                            Caption = 'Brought Months Card';
                        }
                        field("Brought Days of Experience"; "Brought Days of Experience")
                        {
                            Editable = false;
                            Caption = 'Brought Days Card';
                        }
                    }
                    group("Brought Years in Company")
                    {



                        Caption = 'Brought Years in Curr. Company';

                        field("Brought Years of Exp. in Curr."; "Brought Years of Exp. in Curr.")
                        {
                            Editable = false;
                            Caption = 'Brought Years Comp Card';
                        }
                        field("Brought Months of Exp. in Curr."; "Brought Months of Exp.in Curr.")
                        {
                            Editable = false;
                            Caption = 'Brought Months Comp Card';
                        }
                        field("Brought Days of Exp. in Curr."; "Brought Days of Exp.in Curr.")
                        {
                            Editable = false;
                            Caption = 'Brought Days Comp Card';
                        }
                    }
                    group("Brought Total")
                    {



                        Caption = 'Brought Total';

                        field("Brought Years Total"; "Brought Years Total")
                        {
                            Editable = false;
                            Caption = 'Brought Years Total Card';
                        }
                        field("Brought Months Total"; "Brought Months Total")
                        {
                            Editable = false;
                            Caption = 'Brought Months Total Card';
                        }
                        field("Brought Days Total"; "Brought Days Total")
                        {
                            Editable = false;
                            Caption = 'Brought Days Total Card';
                        }
                    }




                }



            }
            group("Current Company")
            {

                Caption = 'Work Experience in Company';
                //BH 01 start
                grid("Work Experience in Company")
                {
                    GridLayout = Rows;

                    group("Experience in Company")
                    {
                        Caption = 'Experience in Company';

                        field("Years of Experience in Company"; "Years of Experience in Company")
                        {
                            Editable = false;
                        }
                        field("Months of Exp. in Company"; "Months of Exp. in Company")
                        {
                            Editable = false;
                        }
                        field("Days of Experience in Company"; "Days of Experience in Company")
                        {
                            Editable = false;
                        }

                    }
                    group("Current Total")
                    {
                        Caption = 'Current Total';

                        field("Current Years Total"; "Current Years Total")
                        {
                            Editable = false;
                        }
                        field("Current Months Total"; "Current Months Total")
                        {
                            Editable = false;
                        }
                        field("Current Days Total"; "Current Days Total")
                        {
                            Editable = false;
                        }

                    }


                }
                //BH 01 end

            }
            Group("Total experience")

            {
                fixed("Total")
                {


                    Caption = 'Total experience';
                    group("Godine")
                    {

                        field("Years of Experience"; "Years of Experience")
                        {
                            Editable = false;
                            Caption = 'Total Years Card';
                        }
                    }
                    group("Mjeseci")
                    {
                        field("Months of Experience"; "Months of Experience")
                        {
                            Editable = false;
                            Caption = 'Total Months Card';
                        }
                    }
                    group("Dani")
                    {
                        field("Days of Experience"; "Days of Experience")
                        {
                            Editable = false;
                            Caption = 'Total Days Card';
                        }
                    }
                }
            }
            group("MILITARY EXPERIENCE")
            {

                Caption = 'Military Experience';
                //BH 01 start
                grid("Experience with military")
                {
                    GridLayout = Rows;
                    group("Military service")
                    {



                        Caption = 'Military service';

                        field("Military Years of Service"; "Military Years of Service")
                        {
                            Editable = false;
                            Caption = 'Military Years Card';
                        }
                        field("Military Months of Service"; "Military Months of Service")
                        {
                            Editable = false;
                            Caption = 'Military Months Card';
                        }
                        field("Military Days of Service"; "Military Days of Service")
                        {
                            Editable = false;
                            Caption = 'Military Days Card';
                        }
                    }

                    group("Work experience with military")
                    {



                        Caption = 'Work experience with military';

                        field("Years with military"; "Years with military")
                        {
                            Editable = false;
                            Caption = 'With Military Years Card';
                        }
                        field("Months with military"; "Months with military")
                        {
                            Editable = false;
                            Caption = 'With Military Months Card';
                        }
                        field("Days with military"; "Days with military")
                        {
                            Editable = false;
                            Caption = 'With Military Days Card';
                        }
                    }




                }
                //BH 01 end

            }

            group(PLATE)
            {

                //ĐK
                group("Bank data")

                {
                    Caption = 'Bank Data';
                    field("Work Experience Percentage"; "Work Experience Percentage")
                    {
                    }
                    field("Bank No."; "Bank No.")
                    {
                        Caption = 'Bank No.';
                    }

                    field("Bank Account No.2"; "Bank Account No.")

                    {
                        Caption = 'Bank Account No.';
                        TableRelation = "Wage/Reduction Bank Accounts"."No.";
                    }
                    field("Refer To Number"; "Refer To Number")
                    {
                    }


                }

                group(General2)
                {
                    Caption = 'General';
                    //The GridLayout property is only supported on controls of type Grid

                    field("Hours In Day"; "Hours In Day")
                    {
                    }
                    field("Transport Amount"; "Transport Amount")
                    {
                    }
                    field("Wage Type"; "Wage Type")
                    {
                    }
                    field("For Calculation"; "For Calculation")
                    {
                    }
                    field(Meal; Meal)
                    {
                    }
                    field("Send PayList"; "Send PayList")
                    {
                    }
                }
                group("PORESKA OLAKŠICA")
                {
                    field("Tax Deduction"; "Tax Deduction")
                    {
                    }
                    field("Tax Individual"; "Tax Individual")
                    {
                    }
                    field("General Tax"; "General Tax")
                    {
                    }
                    field("Additional Tax"; "Additional Tax")
                    {
                    }
                    field("Tax Deduction Amount"; "Tax Deduction Amount")
                    {
                        Editable = false;
                    }
                }
                group(Posting)
                {
                    Caption = 'Posting';

                    field("Wage Posting Group"; "Wage Posting Group")
                    {
                    }
                    field("Contribution Category Code"; "Contribution Category Code")
                    {

                    }
                }
            }



        }




        addafter("Gender")
        {
            group("Birth Data")
            {


            }




            group("Employement Data")
            {
                field(DepartmentName; EmployeeContractLedger."Department Name")
                {
                    Caption = 'Department Name';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin

                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(SectorDescription; EmployeeContractLedger."Sector Description")
                {
                    Caption = 'Sector Description';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin

                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(Služba; EmployeeContractLedger."Department Cat. Description")
                {
                    Caption = 'Služba';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin

                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(Odjel; EmployeeContractLedger."Group Description")
                {
                    Caption = 'Odjel';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin

                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(PositionName; EmployeeContractLedger."Position Description")
                {
                    Caption = 'Position';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin

                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(StatusP; EmployeeContractLedger.Status)
                {
                    Caption = 'Status';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin

                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(Smjena; EmployeeContractLedger."Rad u smjenama")
                {
                    Caption = 'Rad u smjenama';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin

                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
                field(Superior1; EmployeeContractLedger.Superior1)
                {
                    Caption = 'Superior 1';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin

                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }

                field(Superior2; EmployeeContractLedger.Superior2)
                {
                    Caption = 'Superior 2';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin

                        EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                        EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                        EmployeeContractLedgerPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }
            }
        }
        moveafter("Birth Data"; "Birth Date")
        addafter("No.")
        {



            group("Living information")
            {
                field("Address CIPS"; "Address CIPS")
                {

                }
                field("Municipality Code CIPS"; "Municipality Code CIPS")
                {

                }
                field(Region; Region)
                {

                }
                field("Full Phone No."; "Full Phone No.")
                {

                }
                field("City CIPS"; "City CIPS")
                {

                }
                field("Post Code CIPS"; "Post Code CIPS")
                {

                }
                field("Entity Code CIPS"; "Entity Code CIPS")
                {

                }
                field("Country/Region Code CIPS"; "Country/Region Code CIPS")
                {

                }
            }
            /*group("Employement Data")
            {
                
            }*/

        }
        addbefore("Living information")
        {
            field("Employee ID"; "Employee ID")
            {

            }
        }
        addafter("Gender")
        {
            field(StatusExt; StatusExt)
            {
                Caption = 'Status';
            }


        }
        addafter("Country/Region Code")
        {
            field("Municipality Code"; "Municipality Code")
            {

            }
            /*  field(County2; Canton)
              {

              }
              */
            field("Entity Code"; "Entity Code")
            {

            }

        }

        addafter("Birth Date")
        {
            field("Place of birth"; "Place of birth")
            {

            }
        }
        addafter("Social Security No.")
        {
            field("Disabled Person"; "Disabled Person")
            {

            }
            field("Disabled Child"; "Disabled Child")
            {

            }
            field("Hard Work conditions"; "Hard Work conditions")
            {
                Visible = false;

            }
            field("ID No."; "ID No.")
            {

            }
            field("ID Issued in"; "ID Issued in")
            {

            }
            field("Passport No."; "Passport No.")
            {

            }
            field("Driving Licence"; "Driving Licence")
            {

            }
            field("Driving Llicence Category"; "Driving Llicence Category")
            {

            }
            field("Military rights"; "Military rights")
            {

            }

        }
        addafter("Salespers./Purch. Code")
        {
            field("Short Term Contract"; "Short Term Contract")
            {

            }
            field("Short Term Contract Start Date"; "Short Term Contract Start Date")
            {

            }
            field("Short Term Contract End Date"; "Short Term Contract End Date")
            {

            }
        }


        addafter(Gender)
        {

            field("Marital status"; "Marital status")
            {

            }
        }
        addafter(Personal)
        {
            group(Education)
            {
                field("Education Level"; "Education Level")
                {

                }
                field("School of Graduation"; "School of Graduation")
                {

                }
                field("Major of Graduation"; "Major of Graduation")
                {

                }
                field("Date of graduation"; "Date of graduation")
                {

                }
                field("Employee Computer Knowledge"; "Employee Computer Knowledge")
                {

                }
                field("Employee Qualifications"; "Employee Qualifications")
                {

                }
                field("Employee Languages"; "Employee Languages")
                {

                }

            }
        }
        /*           {field("Related Person to be informed"; "Related Person to be informed")
                   {
                       Visible = false;

                   }
                   field("Tel. No. Of Related Person"; "Tel. No. Of Related Person")
                   {
                       visible = false;

                   }
                   field("Blood Type"; "Blood Type")
                   {
                       visible = false;

                   }
                   field(Size; Size)
                   {

                   }
                   field("Clothing size"; "Clothing size") { }
                   field("Shoe size"; "Shoe size") { }
                   field("Last Date Modified2"; "Last Date Modified") { }
                   field("Salesperson Code"; "Salesperson Code") { }
               }*/


        addafter(General)
        {
            group(Administration2)
            {
                Caption = 'Administration of Employment';
                group(Administration3)
                {

                    Caption = 'Administration';
                    field("Employment Date3"; "Employment Date")
                    {
                        Caption = 'Employment Date';
                        Editable = false;
                        Importance = Promoted;
                        ShowMandatory = true;
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        begin
                            /*EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.","No.");
                            EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;*/

                            workbooklet.RESET;
                            WorkBooklet.SETFILTER("Employee No.", "No.");
                            WorkBooklet.SETFILTER(Active, '%1', TRUE);
                            WorkBooklet.SETFILTER("Hours change", '%1', FALSE);
                            WorkBookletPage.SETTABLEVIEW(WorkBooklet);
                            WorkBookletPage.RUN;
                            CurrPage.UPDATE;

                        end;

                        trigger OnValidate()
                        begin
                            /*IF "Employment Date" > "Probation Period Start" THEN
                            ERROR(Text010);  */

                        end;
                    }

                    field(EmployeeContractLedgerBrutto; EmployeeContractLedger.Brutto)
                    {
                        Caption = 'Brutoo';
                        Editable = false;
                        Importance = Promoted;
                        //Visible = show2;
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EmployeeContractLedgerNetto; EmployeeContractLedger.Netto)
                    {
                        Caption = 'Netto';
                        Editable = false;
                        Importance = Promoted;
                        ApplicationArea = all;
                        //  Visible = show2;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EmployeeContractLedgerTotalNetto; EmployeeContractLedger."Total Netto")
                    {
                        Caption = 'Total Netto';
                        Editable = false;
                        ApplicationArea = all;
                        // Visible = show2;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EmployeeContractLedgerWageType; EmployeeContractLedger."Wage Type")
                    {
                        Caption = 'Wage Type';
                        Editable = false;
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }

                    field("<Work Experience Percentage Copy>"; "Work Experience Percentage")
                    {
                        Caption = 'Work Experience Percentage';
                        Editable = false;
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        begin
                            WageCalc.RESET;
                            WageCalc.SETFILTER("Employee No.", "No.");
                            WageCalcSub.SETTABLEVIEW(WageCalc);
                            WageCalcSub.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EmployeeContractLedgerFirstTimeEmployed; EmployeeContractLedger."First Time Employed")
                    {
                        Caption = 'First Time Employed';
                        Editable = false;
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EmployeeContractLedgerWayofEmployment; EmployeeContractLedger."Way of Employment")
                    {
                        Caption = 'Way of Employment';
                        Editable = false;
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EmployeeContractLedgerPrentice; EmployeeContractLedger.Prentice)
                    {
                        Caption = 'Prentice';
                        Editable = false;
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    /*    field("Professional Examination Date"; "Professional Examination Date")
                        {
                            ApplicationArea = all;
                        }
                        field("Professional Exam. Result"; "Professional Exam. Result")
                        {
                            ApplicationArea = all;
                        }*/
                    field(EmployeeContractLedgerEngagementType; EmployeeContractLedger."Engagement Type")
                    {
                        Caption = 'Contract Type';
                        ApplicationArea = all;
                        Editable = false;
                        Importance = Promoted;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EmployeeContractLedgerStartingDate; EmployeeContractLedger."Starting Date")
                    {
                        Caption = 'Starting Date';
                        Editable = false;
                        Importance = Promoted;
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        begin
                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }
                    field(EmployeeContractLedgerEndingDate; EmployeeContractLedger."Ending Date")
                    {
                        Caption = 'Ending Date';
                        Editable = false;
                        Importance = Promoted;
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        begin

                            EmployeeContractLedger.RESET;
                            EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                            EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                            EmployeeContractLedgerPage.SETTABLEVIEW(EmployeeContractLedger);
                            EmployeeContractLedgerPage.RUN;
                            CurrPage.UPDATE;
                        end;
                    }

                }

            }
            /*group("Potential Employe")
            {
                Caption = 'Potential Employe';
                field("Potential Employee"; "Potential Employee")
                {

                }
                field("Potential Base Status"; "Potential Base Status")
                {

                }
                field("Documentation delivered"; "Documentation delivered")
                {

                }
                field("Invited to interview"; "Invited to interview")
                {

                }
                field("Appropriate candidate"; "Appropriate candidate")
                {

                }
                field("Inappropriate candidate"; "Inappropriate candidate")
                {

                }


            }*/

        }


    }

    actions
    {
        modify("Ledger E&ntries")
        {
            Visible = false;
        }
        modify(PayEmployee)
        {
            Visible = false;

        }
        // Add changes to page actions here

        addafter(Dimensions)
        {

            action("Work Booklet")
            {
                Caption = 'Work booklet';
                Image = Workdays;

                RunObject = page "Work booklet";
                RunPageLink = "Employee No." = FIELD("No.");
                //  RunObject = report "";
            } // Add changes to page actions here

            action("Wage amount")
            {
                Caption = 'Wage Amounts';
                Image = AmountByPeriod;
                RunObject = page "Wage Amounts";
                RunPageLink = "Employee No." = field("No.");
            }
            action("Employee Default dimension")
            {
                Caption = 'Employee Default dimension';
                Image = Dimensions;
                RunObject = page "Employee Default Dimension";
                RunPageLink = "No." = field("No.");

            }

            //ED 01 START
            action("Employee absence")
            {
                Caption = 'Employee Absence';
                Image = Workdays;
                RunObject = page "Employee Absence";
                RunPageLink = "Employee No." = FIELD("No.");
            }
            //ED 01 END

        }
    }

    var

    var
        myInt: Integer;
        StartDate: Date;
        WA: Record "Wage Addition";
        UnionEmployees: record "Union Employees";
        UnionEmployeesPage: page "Union Employees";
        UserPersonalisation: Record "User Personalization";
        UserPersonalisation2: record "User Personalization";
        showMC: Boolean;
        TerminationVisible: Boolean;
        EmploymentAbroadVisible: Boolean;
        Educ: Record "Additional Education";
        EducationHistoryPage: Page "Education History";
        EmployeeDisability: record "Employee Level Of Disability";

        EmployeeDisabilityPage: page "Employee Level Of Disability";
        EndDate: Date;
        AdditionalEducation: record "Additional Education";
        PersonalDocumentsPage: Page "Personal Documents";
        EmployeeDisability1: Record "Employee Level Of Disability";
        PersonalDocumentsNat: Record "Personal Documents";
        show2: Boolean;
        show: Boolean;
        emp: Record employee;
        PersonalDocumentsCit2: Record "Personal Documents";
        PersonalDocumentsCit1: Record "Personal Documents";
        //FirstDayOfWeek:
        //FirstDayOfWeek:
        age: Page "ORG Dijelovi";
        //WAPage: page "Wage AdditWag"Calculaged" Addition Calculated";


        DayOfWeekInput: DotNet FirstDayOfWeek;
        WeekOfYearInput: DotNet FirstWeekOfYear;
        //WAPage: page "Wage Addition Calculated";
        //WAPage: page "Wage Addition Calculated";
        ThisYearFirst: Date;
        AgeT: Decimal;
        ThisYear: Integer;
        EC: Record "Employment Contract";
        ContractType: Text[250];
        MothersMaidenName: Text[100];
        FathersName: Text[100];
        MotherName: Text[100];
        ThisMonthLast: Date;
        NextMonthFirst: Date;
        ////WPAgeDVPagAPaJeblations";
        ////WPAgeDVPagAPaJeblations";
        RelativesEmployees: Integer;
        EmployeeRelative: Record "Employee Relative";
        EmployeeRelativePage: Page "Employee Relatives";
        UnionEmployees1: Record "Union Employees";
        //WDVPAge: Page "Job Violations";
        //WDVPAge: Page "Job Violations";
        ManagementLevel: Code[10];
        Position: Record Position;
        TerminationDate: Date;

        EmployeeContractLedger: Record "Employee Contract Ledger";
        EmployeeContractLedgerPage: Page "Employee Contract Ledger";
        hide: Boolean;
        enable: Boolean;
        WorkBooklet: Record "Work Booklet";

        isVisible: Boolean;
        WageCalculation: Record "Wage Calculation";
        WorkBookletPage: page "Work booklet";
        WageCalcSub: Page "Wage Calculation Subform";
        WageCalc: Record "Wage Calculation";
        Text010: Label 'Probation period start date cannot be before employment date.';
        EmploymentDate: Date;
        PersonalDocuments: record "Personal Documents";
}