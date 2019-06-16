{extends file="tinymce/layout.tpl"}
{block name="head:title"}Search News{/block}
{block name="head:script"}news/mc_news.js{/block}
{block name="main:content"}
    <div class="container">
        <div id="template-container">
            <form action="#" class="validate_form">
                {include file="language/brick/dropdown-lang.tpl" label=false onclass=true}
                <div class="tab-content">
                    {foreach $langs as $id => $iso}
                    <fieldset role="tabpanel" class="tab-pane{if $iso@first} active{/if}" id="page-lang-{$id}">
                        <h2>Ajouter un lien</h2>
                        <div class="form-group">
                            <div id="{$iso['iso']}news" class="btn-group btn-block selectpicker" data-clear="true" data-live="true">
                                <a href="#" class="clear"><span class="fas fa-times"></span><span class="sr-only">Annuler la sélection</span></a>
                                <button data-id="parent" type="button" class="btn btn-block btn-default dropdown-toggle">
                                    <span class="placeholder">Choississez un lien à ajouter</span>
                                    <span class="caret"></span>
                                </button>
                                <div class="dropdown-menu">
                                    <div class="live-filtering" data-clear="true" data-autocomplete="true" data-keys="true">
                                        <label class="sr-only" for="input-news">Rechercher dans la liste</label>
                                        <div class="search-box">
                                            <div class="input-group">
													<span class="input-group-addon" id="search-news">
														<span class="fa fa-search"></span>
														<a href="#" class="fa fa-times hide filter-clear"><span class="sr-only">Effacer filtre</span></a>
													</span>
                                                <input type="text" placeholder="Rechercher dans la liste" id="input-news" class="form-control live-search" aria-describedby="search-news" tabindex="1" />
                                            </div>
                                        </div>
                                        <div id="filter-news" class="list-to-filter tree-display">
                                            <ul class="list-unstyled">
                                            {include file="tinymce/loop/link-list.tpl" data=$news[$id] type='news'}
                                            </ul>
                                            <div class="no-search-results">
                                                <div class="alert alert-warning" role="alert"><i class="fa fa-warning margin-right-sm"></i>Aucune entrée pour <strong>'<span></span>'</strong> n'a été trouvée.</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="{$iso['iso']}news_id" id="{$iso['iso']}news_id" class="form-control news_id" value="" data-lang="{$iso['iso']}"/>
                        </div>
                    </fieldset>
                    {/foreach}
                </div>
            </form>
            <form id="news-link" action="#" method="post" class="validate_form collapse">
                <div class="form-group">
                    <label for="text">Texte affiché</label>
                    <input type="text" id="text" class="form-control required" placeholder="Texte affiché" required/>
                </div>
                <div class="form-group">
                    <label for="title">Libellé du lien</label>
                    <input type="text" id="title" class="form-control required" placeholder="Texte au survol" required/>
                </div>
                <div class="form-group">
                    <label for="url">URL du lien</label>
                    <input type="text" id="url" class="form-control required" value="" readonly required/>
                </div>
                <div class="form-group">
                    <label for="blank">Ouvrir le lien dans un nouvel onglet</label>
                    <div class="switch">
                        <input type="checkbox" id="blank" class="switch-native-control" />
                        <div class="switch-bg">
                            <div class="switch-knob"></div>
                        </div>
                    </div>
                </div>
                <button type="submit" class="btn btn-main-theme">Insérer le lien</button>
            </form>
        </div>
    </div>
{/block}