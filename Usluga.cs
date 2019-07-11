DateTime.ParseExact(this._localConfig[], "yyyy-MM-dd HH:mm", CultureInfo.InvariantCulture);
string.Format("{0:yyyy-MM-dd HH:mm:ss} {1}", DateTime.Now, message)        

            
private void MonitorujKorektyZawinione()
        {
            Base.TypUslugi u = Base.TypUslugi.KorektyZawinione;
            var canContinue = true;
            DateTime start;
            Base.BLL.Result r = new Base.BLL.Result(Base.TypUslugi.KorektyZawinione);
            Base.BLL.Settings settings;
            string message;

            while (canContinue)
            {
                try
                {                    
                    settings = new Base.BLL.Settings();
                    if (!settings.KorektyZawinioneAktywne)
                    {
                        message = "Obsługa korekt zawinionych jest wyłączona.";
                        Base.Current.Log.WriteEntry(message, EventLogEntryType.Warning, 1054);
                        Base.DAL.Cfg.Save("KorektyZawinioneResult", string.Format("{0:yyyy-MM-dd HH:mm:ss} {1}", DateTime.Now, message));
                        start = DateTime.Now.AddDays(1);
                    }
                    else
                    {
                        message = "Obsługa korekt zawinionych jest włączona.";
                        Base.Current.Log.WriteEntry(message, EventLogEntryType.Information, 1054);
                        Base.DAL.Cfg.Save("KorektyZawinioneResult", string.Format("{0:yyyy-MM-dd HH:mm:ss} {1}", DateTime.Now, message));

                        start = Base.DAL.Konfiguracja.GetStartCzas(ref r, u);
                        Base.Current.Log.WriteEntry(r.Message, r.Correct ? EventLogEntryType.Information : EventLogEntryType.Error, r.EventID);
                        Base.DAL.Cfg.Save("KorektyZawinioneResult", string.Format("{0:yyyy-MM-dd HH:mm:ss} {1}", DateTime.Now, r.Message));
                        if (!r.Correct)
                        { start = DateTime.Now.AddDays(1); }

                        else
                        {
                            if (settings.KorektyZawinioneStartDzien.Date <= DateTime.Now.Date && D2M(settings.KorektyZawinioneLastSend) < D2M(DateTime.Now))
                            {
                                System.Threading.Thread.Sleep(start - DateTime.Now);
                                if (Base.DAL.KorektyZawin.IsOK(ref r))
                                {
                                    Base.Current.Log.WriteEntry(r.Message, EventLogEntryType.Information, r.EventID);
                                    if (Base.DAL.KorektyZawin.SendMail(ref r))
                                    {
                                        Base.DAL.Cfg.Save("KorektyZawinioneLastSend", string.Format("{0:yyyy-MM-dd HH:mm:ss} {1}", DateTime.Now, r.Message));
                                    }

                                    Base.Current.Log.WriteEntry(r.Message, EventLogEntryType.Information, r.EventID);
                                    Base.DAL.Cfg.Save("KorektyZawinioneResult", r.Message);
                                    start = DateTime.Now.AddHours(23);
                                }
                                else
                                {
                                    Base.Current.Log.WriteEntry(r.Message, EventLogEntryType.Information, r.EventID);
                                }
                            }
                        }
                    }

                    System.Threading.Thread.Sleep(start - DateTime.Now);
                }
                catch (Exception ex)
                {
                    Base.Current.Log.WriteEntry(ex.Message, EventLogEntryType.Error, r.EventID);
                    Base.DAL.Cfg.Save("KorektyZawinioneResult", ex.Message);
                    return;
                }
            }

            
        }



            
            DateTime monthCurr;
            DateTime monthLast;
            
            

            
            while (canContinue)
            {
                try
                {
                    System.Threading.Thread.Sleep(start - DateTime.Now);
                                      
                    monthCurr = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                    monthLast = new DateTime(settings.KorektyZawinioneStopCzas.Year, settings.KorektyZawinioneStopCzas.Month, 1);                   

                    if (settings.KorektyZawinioneAktywne)
                    {
                        if (settings.KorektyZawinioneLastSend == Base.SendResult.Tak
                            && monthCurr > monthLast)
                        {
                            settings.KorektyZawinioneLastSend = Base.SendResult.Nie;
                            Base.DAL.Cfg.Save("KorektyZawinioneLastSend", ((int)Base.SendResult.Nie).ToString());

                        }

                        if (settings.KorektyZawinioneLastSend != Base.SendResult.Tak)
                        {
                            if (settings.KorektyZawinioneStartDzien <= DateTime.Now.Date)
                            {
                                
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    
                }
                start = start.AddDays(1);
            }


Base.Current.Log.WriteEntry(r.Message, r.Correct ? EventLogEntryType.Information : EventLogEntryType.Error, r.EventID);
            Base.DAL.Cfg.Save("FakturyWystawioneResult", r.Message);
            if (!r.Correct)
            { return; }

            DateTime start = Base.DAL.Konfiguracja.GetStartCzas(ref r, u);
            Base.Current.Log.WriteEntry(r.Message, r.Correct ? EventLogEntryType.Information : EventLogEntryType.Error, r.EventID);
            Base.DAL.Cfg.Save("FakturyWystawioneResult", r.Message);
            if (!r.Correct)
            { return; }

            while (canContinue)
            {
                System.Threading.Thread.Sleep(start - DateTime.Now);
                start = start.AddDays(1);
                //System.Threading.Thread.Sleep(1800000);
                if (!Base.DAL.FakturyWyst.IsOK(ref r))
                {
                    Base.Current.Log.WriteEntry(r.Message, EventLogEntryType.Information, r.EventID);
                    Base.DAL.Cfg.Save("FakturyWystawioneResult", r.Message);

                    if (Base.DAL.FakturyWyst.SendMail(ref r))
                    { Base.DAL.Cfg.Save("FakturyWystawioneLastSend", ((int)Base.SendResult.Tak).ToString()); }
                    else
                    { Base.DAL.Cfg.Save("FakturyWystawioneLastSend", r.Correct ? ((int)Base.SendResult.Nie).ToString() : ((int)Base.SendResult.Błąd).ToString()); }
                    Base.Current.Log.WriteEntry(r.Message, EventLogEntryType.Information, r.EventID);
                }
                else
                {
                    Base.Current.Log.WriteEntry(r.Message, EventLogEntryType.Information, r.EventID);
                    Base.DAL.Cfg.Save("FakturyWystawioneResult", r.Message);
                }
            }